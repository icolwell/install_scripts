#!/bin/bash
set -e

EXCLUDE_SCRIPTS=(
docker_install.bash
nvidia_driver_install.bash
opera_install.bash
prometheus_apache_exporter_install.bash
prometheus_install.bash
prometheus_node_exporter_install.bash
slack_install.bash
steamlink_install.bash
)

main()
{
	# Loop over all scripts, test each one
	for script in *.bash; do
		if [[ ! " ${EXCLUDE_SCRIPTS[@]} " =~ " ${script} " ]]; then
			echo ""
			echo "--- Testing $script ---"
			echo ""
			bash "$script"
		else
			echo ""
			echo "Skipping $script"
			echo ""
		fi
	done
}

main
