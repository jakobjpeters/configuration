
set shell := ["nu", "--commands"]

# build Docker image
build name="all":
    sudo docker buildx build --build-arg NAME={{name}} --tag configuration_{{name}} .

# install the given program(s)
install name="all":
    nu scripts/install/{{name}}.nu

# run Docker image shell
run name="all":
    sudo docker run --interactive --tty configuration_{{name}}

#
test name="all":
    nu scripts/test.nu {{name}}

# update dependencies
update:
    nu scripts/update.nu
