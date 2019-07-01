function k8validate() {
	kubectl apply --validate=true --dry-run=true --filename=$(pwd)/$1
}
