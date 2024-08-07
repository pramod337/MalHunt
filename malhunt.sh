#bin/bash
clear
echo ""
echo "Enter link--"

read link

wget -q -O output.txt --no-check-certificate $link

#wget -q -O output.txt $link

#searching malicious code in main page with output.txt
echo "seraching malicious code on home page...."
echo ""
echo ""
grep -n "(function(n,t){var r=" output.txt
grep -n 'function _0x' output.txt
grep -n 'document.createElement("script")' output.txt
grep -n 'document.write(' output.txt
grep -n 'document.write(atob' output.txt



#getting main page links of only .js ending
grep -o 'https\?://[^'\''"]*' output.txt | grep '.js' > main_page_links.txt


#getting links inside mainpage.txt.... and putting on all_links.txt
grep '<a href' output.txt | grep "$link" | grep -o 'https\?://[^'\''"]*' output.txt | grep -v '.css' | grep -v '.png' > all_links.txt

#The links inside all_links.txt are now filtering for .js, wp-content etc... and storing on filtered_links.txt
grep "$link" all_links.txt | grep -v 'wp-content' | grep -v 'wp-includes' | grep -v '%' |grep -v 'archives' | grep -v 'xmlrpc' | grep -v 'wp-json' > filtered_links.txt

#sort filtered_links | uniq > uniq_links.txt
echo ""


grep -o 'document.write(atob' output.txt
#grep '<script' output.txt
#cat main_page_links.txt


echo "checking main page links...."
while IFS= read -r url; do

    wget -q -O  huntmal.txt "$url"
    echo $url
grep -o "(function(n,t){var r=" huntmal.txt
grep -o 'function _0x' huntmal.txt
grep -o 'document.createElement("script")' huntmal.txt
grep -o 'document.write(' huntmal.txt
grep -o 'document.write(atob' huntmal.txt
    rm huntmal.txt
done < main_page_links.txt

echo "checking subpage links.... that stored on filtered_links.txt file"

while IFS= read -r url; do

    wget -q -O huntmal.txt "$url"
    echo $url

 # wget -q -O sub_links_content.txt $url

    #grep '<a href' sub_links_content.txt | grep "$link" | grep -o 'https\?://[^'\''"]*' sub_links_content.txt | grep -v '.css' | grep -v '.png' | grep 'wp-content' | grep '.js'

grep -o "(function(n,t){var r=" huntmal.txt
grep -o 'function _0x' huntmal.txt
grep -o 'document.createElement("script")' huntmal.txt
grep -o 'document.write(' huntmal.txt
grep -o 'document.write(atob' huntmal.txt
    rm huntmal.txt
    #rm sub_links_content.txt
done < filtered_links.txt
~ $
