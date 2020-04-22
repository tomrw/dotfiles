alias k=kubectl

function k8validate() {
	kubectl apply --validate=true --dry-run=true --filename=$(pwd)/$1
}

function k8cron() {
	local name=${1:-""}
	local namespace=${2:-default}

	kubectl get -n $namespace cronjob | grep $name
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
	local namespace=${2:-default}

	kubectl get configmap -o yaml $1 -n $namespace
}

function k8podInfo() {
	local namespace=${2:-default}

	/usr/local/bin/watch kubectl get pods --selector=app=$1 -n $namespace
}

function k8image() {
	if [ "$1" = "" ]; then
		echo "Please specify what to exec"
		return 0
	fi

	local namespace=${2:-default}

	kubectl -n $namespace exec -ti $1 sh
}

function k8logs() {
	if [ "$1" = "" ]; then
		echo "Please specify what to log"
		return 0
	fi

	local namespace=${2:-default}

	kubectl logs -n $namespace -f deployment/$1 --all-containers=true --timestamps
}

function k8editConfigMap() {
	if [ "$1" = "" ]; then
		echo "Please specify what to log"
		return 0
	fi

	local namespace=${2:-default}

	kubectl edit configmap $1 -n $namespace
}

function k8restart() {
	if [ "$1" = "" ]; then
		echo "Please specify what to log"
		return 0
	fi

	local namespace=${2:-default}
	local replicas=$(kubectl -n $namespace get deployment $1 -o=jsonpath='{.spec.replicas}')

	kubectl -n $namespace scale deploy $1 --replicas=0
	sleep 2
	kubectl -n $namespace scale deploy $1 --replicas=$replicas
}

function k8scale() {
	if [ "$1" = "" ]; then
		echo "Please specify what to log"
		return 0
	fi

	if [ "$2" = "" ]; then
		echo "Please specify the number of replicas"
		return 0
	fi

	local namespace=${3:-default}

	kubectl -n $namespace scale deploy $1 --replicas=$2
}

function k8cronLogs() {
	if [ "$1" = "" ]; then
		echo "Please specify what to log"
		return 0
	fi

	local namespace=${2:-default}

	name=$(kubectl get jobs -n $namespace --no-headers -o custom-columns=":metadata.name" --sort-by=.metadata.creationTimestamp | grep $1 | tail -1)

	echo $name

	kubectl logs job/$name -f -n $namespace
}

declare -a k8Fns=(
	"k8logs"
	"k8podInfo"
	"k8configMap"
	"k8deploy"
	"k8editConfigMap"
	"k8restart"
	"k8cron"
	"k8scale"
)

for fn in "${k8Fns[@]}"
do
	complete -F _codeComplete $fn
done
