## What is Replica Set ?

Replica set is a kubernetes resource which is reponsible for maintaing a specified number of identical pods all the time. ReplicaSet automatically detect and recover from pods failures by creating new replicas to replace the failed ones, ensuring that the desired state of the application is maintained. This is called self-healing or auto-healing.
