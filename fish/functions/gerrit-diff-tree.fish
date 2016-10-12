function gerrit-diff-tree
	tree > /tmp/after.txt ;; git co -q @^ ;; tree > /tmp/before.txt ;; kdiff3 /tmp/before.txt /tmp/after.txt ;; git co -q - ;; rm /tmp/{before,after}.txt
end
