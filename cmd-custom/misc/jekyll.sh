function jekyll-new-post()
{
    echo -n "input slug: "
    read slug
    postfile=$(date +%F)-$slug.md
    touch $postfile
    echo "---" > $postfile
    echo -n "input title: "
    read title
    echo "title: $title" >> $postfile
    echo "date: $(date "+%Y-%m-%d %H:%M:%S %z")" >> $postfile
    echo -n "input categories: "
    read categories
    echo "categories: $categories" >> $postfile
    echo -n "input tags: "
    read tags
    echo "tags: $tags" >> $postfile
    echo "---" >> $postfile
    case "$(uname)" in
        "Darwin")
            open $postfile
        ;;
        "Linux")
            editor $postfile
        ;;
    esac
}
