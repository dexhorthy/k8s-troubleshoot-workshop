Workshop Walkthrough
=========================



Outline
--------

1. Using support bundles to summarize workload status 
2. Fixing resource problems / reviewing summary
3. Using support bundles to understand workload behvior
4. Providing feedback to end users to fix problems
5. Additional Challenges for the brave
 
Prerequisites 
--------

A small Kubernetes cluster. For the CPU constraint logic to work as intended, a single-node cluster with 1 CPU core is recommended. Docker desktop or minikube are appropriate choices here. With GKE, you can accomplish this with:

```shell
export CLUSTER=dex-tiny-cluster
gcloud container clusters create $CLUSTER --machine-type=n1-standard-1 --no-enable-ip-alias  --num-nodes=1
```

Get your kubectl config for GKE with

```shell
gcloud container clusters get-credentials $CLUSTER
```

You can validate access with

```shell
kubectl get node
```
 
Workshop Steps
------------

####  epilogue: cleaning up

If you started this workshop but are now coming back to it and want to start fresh, you can run the following. Note that this will delete everything running in your default namespace

```text
kubectl delete deploy,svc --all -n default -l app=myapp
kubectl delete ns load-ns
```

####  prologue: maxing out node CPU

Apply a dummy workload from this repo to max out node CPU to simulate a resource constraint.
Note: This is designed to use lots of CPU - use caution and don't deploy it to a production or autoscaling cluster!

```shell
kubectl apply -f supporting-materials/loader-pod.yaml
```

You should see

```text
namespace/load-ns created
deployment.apps/load-app created
```

If it's working, you should see CPU maxed out (note - not all clusters will support `kubectl top node`)

```text
$ kubectl top node
NAME                                              CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
gke-dex-tiny-cluster-default-pool-9dad0d7a-1m68   1000m        106%   915Mi           34%
```

#### prologue: deploying the app

Deploy the app that we're going to be troubleshooting today:

```shell
kubectl apply -f app-deployment.yaml
```


If you're so inclined, you can use the plain `kubectl` method to ensure things are broken as expected.

```shell
kubectl get pod
```

Should show

```text
NAME                     READY   STATUS    RESTARTS   AGE
my-app-9595cd9c7-4tpvx   0/1     Pending   0          3s
```

And you can use `kubectl describe pod my-app` to review in detail.

#### Collecting Cluster Resources

Now that we've got our app deployed and broken, we can start exploring the Troubleshoot.sh framework:

Using the docs at [Cluster Info](https://troubleshoot.sh/docs/collect/cluster-info/) and [Cluster Resources](https://troubleshoot.sh/docs/collect/cluster-resources/) let's create a simple spec to collect core cluster information.

```shell
cat <<EOF > support-bundle.yaml 
apiVersion: troubleshoot.sh/v1beta2
kind: SupportBundle
metadata:
  name: workshop
spec:
  collectors:
    - clusterInfo: {}
    - clusterResources:
        namespaces:
        - default
EOF
```

#### Installing the `support-bundle` CLI

Now that we have a simple spec, we can collect a support bundle.
We'll start by installing the `kubectl support-bundle` plugin.
This will require that you [install krew.dev on your workstation](https://krew.sigs.k8s.io/docs/user-guide/setup/install/)

```shell
kubectl krew install support-bundle
```

Check this is working with:

```shell
kubectl support-bundle version
```

This workshop is tested with

```text
Replicated Troubleshoot 0.42.0
```


#### Collecting a bundle

Now that we have `kubectl support-bundle` and our `support-bundle.yaml` file ready, we can collect a bundle:


- collecting a bundle
- what's in a bundle - deployments
- Analyzing deployment statuses
- what's in a bundle - pod status
- Analyzing pod statuses
  - adding a node (or deleting the offending workflow)
  - reverse-testing our analyzer
- Aside: Cleanup and Iterating on bundles
- Collecting Pod Logs
- what's in the pod logs
- Analyzing Pod Logs
- Aside: previous / double
- Exercise for the workshop -- can you inspect that annotation without reading the logs? (hint: use jsoncompare)
- Execing Pods
- Exercise for the workshop -- can you analyze the output of the pod exec output and warn if it's using the default? (see if its default nginx or not)
- Exercise for the workshop -- can you do the same with an http collector instead?
