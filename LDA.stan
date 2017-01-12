data{
	int<lower=0> N; // num samples
	int<lower=0> M; // num features
	int<lower=2> K; // num topics
	real X[N,M];
	vector<lower=0>[K] alpha; //topic prior
  vector[M] beta; //feature prior
  matrix[M,M] Sigma;
  real<lower=0> sigma;
}
parameters{
	simplex[K] theta[N]; // topic dist for doc i
	vector[M] mu[K]; //feature dist for topic k
}
model{
  real gamma[K];
	for(i in 1:N){
	  theta[i] ~ dirichlet(alpha); 
	}
	for(k in 1:K){
	  mu[k] ~ multi_normal(beta,Sigma);
	}
	for(i in 1:N){
	  for(j in 1:M){
	    for(k in 1:K){
	      gamma[k] = exp(-1/(2*sigma^2)*(X[i,j]-mu[k,j])^2) * theta[i,k];
	    }
	    target += log(sum(gamma));
	  }
	}
}
