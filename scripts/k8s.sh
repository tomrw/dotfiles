function k8validate() {
	kubectl apply --validate=true --dry-run=true --filename=$(pwd)/$1
}

function k8cron() {
	kubectl get cronjob $@
}

function k8createCron() {
	if [ "$1" = "" ]; then
		echo "Please specify what cron to run"
		return 0
	fi

	local namespace=${2:-default}
	local timestamp=$(date +%s)

	kubectl create job --from=cronjob/$1 $1-$timestamp -n $namespace
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

function k8configMap() {
	kubectl get configmap -o yaml $@
}

function k8podInfo() {
	kubectl get pods --selector=app=$@
}

function k8exec() {
	if [ "$1" = "" ]; then
		echo "Please specify what to exec"
		return 0
	fi

	local namespace=${2:-default}

	kubectl -n $namespace exec -ti $1 sh
}
