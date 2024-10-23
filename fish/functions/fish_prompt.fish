function fish_prompt
	# status dot
	set -g last $status
	function status_dot
		if test $last = "0" 
			set_color green;
		else 
			set_color red;
		end
		echo "⬤"
		set_color normal;
	end
	set item1 $(status_dot)

	status job-control full

	# jobs 
	function jobs_count
		set_color 90969d -o; echo ⦗$(jobs -p | wc -l)⦘
		set_color normal;
	end
	set item2 $(jobs_count)

	# directory
	function directory
		set -l wd $(string split "/" -- $(pwd))
		set -l wdl $(count -- $wd) 
		set_color blue -o;
		if test $wdl -gt "3" 
			if test $wd[-2] = "home"
				set direc "~"
			else 
				set direc $wd[-1]
			end
		else 
			set direc $(pwd)
		end
		echo $direc
		set_color normal;
	end
	set item3 $(directory)

	# git 
	# git branch 
	function git_branch
		if test $(git branch &> /dev/null; echo $status) = "0"
			set branch :$(git branch | rg "\*" | string replace "*" "" | string trim)
			set_color red -o;
			echo $branch
			set_color -i; echo "⦗"
			set_color normal;
		end
	end
	set item4 $(git_branch)

	# git status
	# add files
	function gs_add	
		if test $(git branch &> /dev/null; echo $status) = "0" 
			set add $(git status --porcelain | string trim | string replace -r " .*" "" | rg "A" | wc -l)
			if test "$add" != "0"
				set_color 9eeb3f -o -i; echo "+"$add" "
				set_color normal;
			end
		end
	end
	set item5 $(gs_add)

	# del files
	function gs_del
		if test $(git branch &> /dev/null; echo $status) = "0" 
			set del $(git status --porcelain | string trim | string replace -r " .*" "" | rg "D" | wc -l)
			if test "$del" != "0"
				set_color d5251f -o -i; echo "-"$del" "
				set_color normal;
			end
		end
	end
	set item6 $(gs_del)

	# mod files
	function gs_mod
		if test $(git branch &> /dev/null; echo $status) = "0" 
			set mod $(git status --porcelain | string trim | string replace -r " .*" "" | rg "M" | wc -l)
			if test "$mod" != "0"
				set_color ff9209 -o -i; echo "✻"$mod
				set_color normal;
			end
		end
	end
	set item7 $(gs_mod)

	# ukn files 
	function gs_ukn
		if test $(git branch &> /dev/null; echo $status) = "0" 
			set unk $(git status --porcelain | string trim | string replace -r " .*" "" | rg "\?" | wc -l)
			if test "$unk" != "0"
				set_color 90969d -o -i;  echo " ?"$unk
				set_color normal;
			end
		end
	end
	set item8 $(gs_ukn)

	# end padding
	function end_padding
		if test $(git branch &> /dev/null; echo $status) = "0"
			set_color 90969d -o -i; echo "⦘"
			set_color normal;
		end
		echo " "
	end
	set item9 $(end_padding)

	string join "" $item1 $item2 $item3 $item4 $item5 $item6 $item7 $item8 $item9
end
