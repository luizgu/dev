source $(dirname $0)/common.source

for component in $REPOS
do
	if [ ! -d $component ]; then
		echo "# cloning $component"
		sayAndDo git clone git@github.com:RangeNetworks/$component.git
		cd $component
		for remote in `git branch -r | grep -v master `
		do
			sayAndDo git checkout --track $remote
		done
		sayAndDo git checkout master
		sayAndDo git submodule update --init --recursive --remote
		# sayAndDo doesn't like this string at all, can't seem to get the quoting right
		git submodule foreach 'git checkout `git config -f $toplevel/.gitmodules submodule.$name.branch`'
		cd ..
		echo
	fi
done
