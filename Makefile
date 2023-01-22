install:
		pip install pip --upgrade pip &&\
		pip install -r requirements.txt

lint:
		# echo "From Recepie 2 after 1"

test:
		# test

format:
		# format
all:
		install lint test format