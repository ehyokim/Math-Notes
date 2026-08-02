= Graph Neural Networks
Referenced works: @bishop2023deep

#let datamat = $bold(X)$
#let graph = $cal(G) = (cal(V), cal(E))$
#let embednodevec = $bold(h)_i^(\(ell\))$
#let agg = math.serif("Aggregate")
#let update = math.serif("Update")
#let mlp = math.serif("MLP")


== Introduction 

A Graph Neural Network (GNN) is a neural network which simply takes graphs as input. The key idea here is that since the input data has graph structure, the model can be designed to exploit inductive biases. Many datasets such as social networks, traffic flow, and physics simulations can all take advantage of this inductive bias.

Let $cal(G) = (cal(V), cal(E))$ be the usual definition of a graph where, for simplicity, we assume that the graph is undirected. Here, define $N = |V|$. Let $cal(A)$ be the symmetric adjacency matrix of $cal(G)$. As with many deep learning models, we will have input embeddings of the nodes. For node $i$, let $bold(x)_i$ denote its $D$-dimensional embedding vector. We can stack these embedding vectors into a $N times D$ data matrix $bold(X)$ such that:
$ bold(X) = vec(bold(x)_1^T, bold(x)_2^T, dots.v, bold(x)_N^T) $

One property we want our model to have is _permuatation invariance_. This means that the output of the neural network should not depend on the labeling of the nodes. In other words, let $bold(P)$ be a $N times N$ permutation matrix. If we permute the data $tilde(bold(X)) = bold(P) bold(X)$ and permuate the labels of the nodes as 

$ tilde(cal(A)) = bold(P) cal(A) bold(P)^T  $
then, defining our neural network to be $y_theta$ with learnable parameters $theta$, the following must hold:
$ y_theta (tilde(bold(X)), tilde(cal(A))) = y_theta (bold(X), cal(A)) $

This is the called the _invariance property_. It tells us, under any arbitrary permutation of the labels on the nodes, the neural network must give the same output. 

Furthermore, we may want to make predictions associated to each node. A good example of this is if we are given a large social network graph as input and we must decide if each person is either Democrat or Republican. This is a binary classification task on each node in the input graph. In that case, the predictions should not be dependent on the labeling of the nodes. To this end, we can formulate the desired property as follows: 

Let $bold(y) (dot, dot)$ define the $N times 1$ vector of predictions where each element is associated with a node in the graph. We wish that:
$ bold(y) (tilde(bold(X)), tilde(cal(A))) = bold(P) bold(y) (bold(X), cal(A)) $


This is called the _equivariance property_. 

== GNNs

Like any neural network, we have $L+1$ layers where information processing takes place. Let $bold(h)^(\(ell\))_i$ be the embedding vector of node $i$ outputted by the $ell^("th")$ layer. If we let $bold(X)$ denote our data matrix as above, we define $bold(h)^(\(0\))_i = bold(x)_i$ or the $i^("th")$ row of #datamat. Let #graph be the input graph in our neural network.

We need to imbue the model with the permutation invariance property to ensure invariance and equivariance. Additionally, we must capture the inductive bias given by the graph structure. This must mean we must utilize the connectivity of the graph.

To build such a model, we will construct a _messaging passing algorithm_ which works as detailed below. 

For layer $ell$ where $1 <= ell <= L$ and a fixed node $i$, we compute the embedding vectors for the next layer $bold(h)^(\(ell + 1\))_i$ in two steps:
$ bold(z)_i^(ell) = #agg ( { bold(h)^(\(ell\))_j }_(j in cal(N)(i) ) ) \
  bold(h)^(\(ell + 1\))_i= #update ( bold(z)_i^(ell), bold(h)_i^(\(ell\)) )
$

where $cal(N)(i)$ refers to the set of neighboring nodes of $i$. The $#agg, #update$ functions themselves may contain learnable parameters, but the main desiderata is to ensure that they do not depend on the labeling of the nodes. They must also be able to accomodate a variable number of neighboring nodes. 

There are several candidates for $#agg$. One is the very simple sum function: simply add the embedding vectors over all neighboring nodes:
$ bold(z)_i^(ell ) = sum_(j in cal(N)(i)) bold(h)_j^(\(ell\)) $

Notice here that this is trivially invariant to arbitrary permutations. However, this has the disadvantage that nodes with more neighbors gain more information flow. To alleviate this, the average may be taken instead: 
$
   bold(z)_i^(ell ) = frac(1, |cal(N)(i)|) sum_(j in cal(N)(i)) bold(h)_j^(\(ell\)) 
$

However, this also discards node-specfic information as it "smooths" over the embedding vectors. This means if two nodes share the same adjacent nodes, their output embedding vectors will come out to be the same. Another method is to take the element-wise maximum over each component of the embedding vector.

We can also take into account the number of neighbors of the neighboring nodes themselves:
$
  bold(z)_i^(ell ) = sum_(j in cal(N)(i)) frac(bold(h)^(\(ell\))_j, sqrt(|cal(N)(i)| dot |cal(N)(j))|)
$

A more succinct way of expressing this is as:
$
  bold(Z)_i^(ell) = bold(D)^(-1/2) cal(A) bold(D)^(-1/2) bold(H)^(\(ell\))_i
$ 

where $bold(D)$ is a diagonal matrix whose entries are $bold(D)_(i i) = |cal(N)(i)|$ and $bold(H)^(\(ell\))$ is the embedding vector matrix whose $i^"th"$ row is $bold(h)_i^(\(ell\))$.

We can even introduce learnable parameters into the $#agg$ function by adding $#mlp$ layers:
$ 
   bold(z)_i^(ell) = #mlp _theta ( sum_(j in cal(N)(i)) #mlp _phi (bold(h)_j^(\(ell\)) ))
$

This turns out to be a universal approximator of any permutation-invariant function that takes a set of embedding vectors and ouputs a single embedding vector.

The output embedding vector $bold(h)_j^(\(ell + 1\)$ is defined as follows:

$
  bold(h)_j^(\(ell + 1\)) = #update ( bold(z)_i^(ell), bold(h)_i^(\(ell\)) ) = f( bold(W)_("neigh") bold(z)_i^(\(ell\)) + bold(W)_("self") bold(h)_i^(\(ell\)) + bold(b)) 
$

where $f$ is a non-linear activation function. Here, $bold(W)_("neigh"), bold(W)_("self")$ are learnable weights. 

== Classification Tasks 

=== Node Classification

One way we can perform node classification is by implementing a linear layer with a softmax function at the end. If $bold(h)^(\(L\))_i$ is the output embedding of node $i$, then we can compute a corresponding softmax score:
$
    y_(i c) = frac( "exp"( bold(w)_c^T bold(h)^(\(L\))_i ), sum_(c' in cal(C)) "exp" ( bold(w)_(c')^T bold(h)^(\(L\))_i )) 
$ 

where $cal(C)$ refers to the classification classes. The total operation can be expressed as:
$
  y_i = "Softmax"(bold(W)_cal(C) bold(h)^(\(L\))_i )
$

where the softmax operation is taken across the resulting $|cal(C)| times 1$ vector. Once again, $bold(W)_cal(C)$ is considered a learnable weight matrix here.

The usual cross entropy loss for multi-class classification problems can be employed here:
$
  cal(L) = - sum_(i in cal(V)_"train") sum_(c in cal(C)) t_(i c) "ln"(y_(i c))
$
$cal(V)_"train"$ denotes the nodes which the model will be trained on. A subset of nodes may not be considered during the training process. However, they will participate in the message passing process in the previous layers, and the model may assign labels to them during inference. This is an example of _transductive_ learning and it can be seen as a form of _semi-supervised_ learning.

=== Edge Classification

An example edge classification could be to determine if an edge exists or not. In this case, we wish to the learn probabilities $p_(i j)$ associated with each edge $e_(i j) in cal(E)$. One method of approaching this problem could be to take the dot product between the embedding vectors associated with the nodes at the end of the edge and push it through a sigmoid activation:
$
  p_(i j) = sigma ( bold(h)_i^T bold(h)_j )
$

Note that here, the ordering of the nodes do not matter since the desired permutation property was preserved by each layer of our neural network.

=== Graph Classification

Similarly, graph classification can be done by considering _all_ output embedding vectors. An example of this can be:
$
  bold(f)( sum_(i in cal(V)) bold(h)^(\(L\))_i )
$

Classification can similarly done through a cross entropy loss. 