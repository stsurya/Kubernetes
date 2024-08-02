# Labels & Selectors

Labels and Selectors are the standard method to group things together in Kubernetes. We can filter the objects based on the criteria like class, kind and functions.

- Labels are the properties attached to each item/object.
- Selector helps us to filter the items/objects which have labels attached to them.

In order to work with labels and Selectors all you need to do is attach the labels to objects with key-value pairs.

Let’s create a Replicaset consisting of 3 different objects, we first label the pod definiation and use selector in a Replicaset to group the pods

```
apiVersion: v1
kind: ReplicaSet
metadata:
 name: simple-webapp
 labels:  ###labels we see here are the labels for replicaSet###
  app: app1
  function: front-end
 annotations:
  buildversion: 1.4
spec:
 replicas: 3
 selector:
  matchLabels:
   app: App1   ####match label with the labels of pod###
 template:
  metadata:
   labels:    ###labels defined under template section are the labels configure on the pods###
    app: app1
    function: front-end
  spec:
   containers:
   - name: simple-webapp
     image: simple-webapp
```

In the above yaml file, we can see labels are defined at two palces. The labels on the Replicaset will be used if we configure some other objects to discover the ReplicaSet.

In order to Connect ReplicaSet to Pods, we used selector field under the ReplicaSet specification to match the label define on the Pods.

`kubectl get pods --selector app=App1`
