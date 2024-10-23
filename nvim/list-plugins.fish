echo {} > plugins.json

set -l plugins_dirs start opt themes
for d in $plugins_dirs
	echo $d
	echo "$(jq --arg darg "$d" '. += {$darg: []}' plugins.json)" > temp.json
	mv temp.json plugins.json
	for p in $(ls pack/plugins/$d)
		set -l treated $(echo $p | string replace "." ":")
		echo "$(jq --arg targ "$treated" --arg darg "$d" '.[$darg] += [$targ]' plugins.json)" > temp.json
		mv temp.json plugins.json
	end
end
