Troubleshooting Guide for My App
=========

*This page is shown as an example documentation page that might be linked to from a troubleshoot analyzer*


### Pevent Start preventing start?

If you need to remove the `prevent-start` annotation, try this handy patch command:

```
kubectl patch deployment my-app -p '{"spec": {"template": {"metadata": {"annotations": {"com.example.myapp/prevent-start": ""}}}}}'
```