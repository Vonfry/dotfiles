function jekyll-new-post
    echo -n "slug: "
    read slug
    set postfile (date +%F)-$slug.md
    touch $postfile

    echo "---" > $postfile

    echo -n "title: "
    read title
    echo "title: $title" >> $postfile

    echo "date: (date "+%Y-%m-%d %H:%M:%S %z")" >> $postfile

    echo -n "categories: "
    read categories
    echo "categories: $categories" >> $postfile

    echo -n "tags: "
    read tags
    echo "tags: $tags" >> $postfile

    echo -n "image: "
    read image
    if test -v "image"; and not test -z $image
        echo "image: $image" >> $postfile
    end

    echo -n "description: "
    read description
    if test -v "description"; and not test-z $description
        echo "description: $description" >> $postfile
    end
    echo -n "twitter_text: "
    read twitter_text
    if test -v "twitter_text"; and not test -z $twitter_text
        echo "twitter_text: $twitter_text" >> $postfile
    end

    echo "---" >> $postfile

    switch (uname)
        case "Darwin"
            open $postfile
        case "Linux"
            editor $postfile
    end
end
