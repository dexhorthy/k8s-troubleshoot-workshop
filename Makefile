

.PHONY: iterate
iterate: cleanup
	vim support-bundle.yaml
	kubectl support-bundle support-bundle.yaml
	tar xvf *.tar.gz 2>&1 | sort

.PHONY: cleanup
cleanup:
	rm -rf support-bundle-2022-* || :
	rm *.tar.gz || :
