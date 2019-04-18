tag=$1
conmit=$(git rev-parse $tag)
git tag -d "$tag"
git tag "deprecated/$2" $conmit
