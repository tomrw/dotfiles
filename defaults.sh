cd setup

for file in * ; do
	echo "Running setup for $file"
	./$file
done
