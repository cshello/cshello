

function gentitles {
    python cshello/scripts/gen_readme_title.py
}


function wrapercode {
    if [ ${1}_ = "-h_" ]; then
	echo \$ wrapercode sh 123
	return 
    fi
    
    echo "\`\`\`$1
$2
\`\`\`
"
}




