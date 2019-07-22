function k8validate() {
	kubectl apply --validate=true --dry-run=true --filename=$(pwd)/$1
}

function k8cron() {
	kubectl get cronjob $1
}

function k8deploy() {
	if [ "$1" = "" ]; then
		echo "Please specify what to deploy"
		return 0
	fi

	if [ "$2" != "" ]; then
		echo "Deploying $1 to $2"
		kubectl -n $2 edit deployment $1
	else
		echo "Deploying $1 to default"
		kubectl -n default edit deployment $1
	fi
}
