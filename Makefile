
include .env
export $(shell sed 's/=.*//' .env)

test:
	@bash tests/ssh-test.sh