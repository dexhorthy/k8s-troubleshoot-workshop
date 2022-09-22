

.PHONY: iterate
iterate: clean
	vim support-bundle.yaml
	kubectl support-bundle support-bundle.yaml
	tar xvf *.tar.gz 2>&1 | sort

.PHONY: clean
clean:
	rm -rf support-bundle-2022-* || :
