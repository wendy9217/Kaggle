setwd("C:/Users/Wendy/Dropbox/GraphicalModelKaggle")
library(rstan)
K <- 2
vb1 <- vb("LDA.stan",data =list(N=dim(train_PCA2[,-1])[1],M=dim(train_PCA2[,-1])[2],K=K,X=train_PCA2[,-1],
                                alpha = rep(0.1,K), beta = colMeans(train_PCA2[,-1])), 
                                iter=1000,tol_rel_obj=0.01)
          
LDA1 <- stan("LDA.stan", data =list(N=dim(train_PCA2[,-1])[1],M=dim(train_PCA2[,-1])[2],K=K,X=train_PCA2[,-1],
                                   alpha = rep(0.1,K), beta = colMeans(train_PCA2[,-1]), 
                                   Sigma = diag(0.5,dim(train_PCA2[,-1])[2]), sigma = 0.1),
             iter=1000,chains=4) #lp__ -2916.769

K <- 3
LDA2 <- stan("LDA.stan", data =list(N=dim(train_PCA2[,-1])[1],M=dim(train_PCA2[,-1])[2],K=K,X=train_PCA2[,-1],
                                    alpha = rep(0.1,K), beta = colMeans(train_PCA2[,-1]), 
                                    Sigma = diag(0.5,dim(train_PCA2[,-1])[2]), sigma = 0.1),
             iter=1000,chains=4) #lp__ -3598.457

K <- 4
LDA3 <- stan("LDA.stan", data =list(N=dim(proj_train_features)[2],M=dim(proj_train_features)[1],K=K,X=t(proj_train_features),
                                    alpha = rep(0.2,K), beta = rowMeans(proj_train_features), 
                                    Sigma = diag(0.5,dim(proj_train_features)[1]), sigma = 0.1),
             iter=1000,chains=4) #-4298.192

#######################
#train the data generated from mainVIDAprogram.R
#######################
K <- 5
LDA4 <- stan("LDA.stan", data =list(N=dim(proj_train_features)[2],M=dim(proj_train_features)[1],K=K,X=t(proj_train_features),
                                    alpha = rep(0.2,K), beta = rowMeans(proj_train_features), 
                                    Sigma = diag(0.5,dim(proj_train_features)[1]), sigma = 0.1),
             iter=1000,chains=4) #-4298.192

#######################
#Load the data in LDA4
######################
sim_LDA3 <- extract(LDA3)
mu_LDA3 <- apply(sim_LDA3$mu,c(2,3),mean)
theta_LDA3 <- apply(sim_LDA3$theta,c(2,3),mean)
LDA3_result<-list(mu=mu_LDA3,theta=theta_LDA3)
