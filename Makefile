start:
	minikube start
.PHONY: start

apply:
	cd deployments/k8s/manifests && kubectl apply -f.
.PHONY: apply

tunnel:
	minikube tunnel
.PHONY: tunnel
