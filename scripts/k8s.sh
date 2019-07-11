function k8validate() {
	kubectl apply --validate=true --dry-run=true --filename=$(pwd)/$1
}

function k8cron() {
	kubectl get cronjob $1
}
