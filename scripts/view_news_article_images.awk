#!/usr/bin/gawk -f

BEGIN {
    "mktemp -d" | getline;
    dir = $0;
    print dir;
}

/\[\w+\]:[[:blank:]]+.*\.(jpg|png)/ {
    system("curl " $2 " > " dir "/`echo " $2 " | tr '/' '!'`");
}

END {
    system("cd " dir " && qiv *.jpg *.png");
    system("rm -rf " dir);
}
