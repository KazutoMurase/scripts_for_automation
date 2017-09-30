#!/bin/bash
PREFIX=$1
outdir=$2
date=`date '+%Y_%m_%d'`
rtmpdump --rtmp "rtmpe://netradio-r2-flash.nhk.jp" \
         --playpath 'NetRadio_R2_flash@63342' \
         --app "live" \
         --swfVfy http://www3.nhk.or.jp/netradio/files/swf/rtmpe.swf \
         --live \
         --stop 900 \
         -o ${outdir}/${PREFIX}_${date}.m4a
ffmpeg -i ${outdir}/${PREFIX}_${date}.m4a -ab 256k ${outdir}/${PREFIX}_${date}.mp3
rm ${outdir}/${PREFIX}_${date}.m4a
echo "${PREFIX} ${date}<br/>" >> "${outdir}/index.html"
echo '<audio src="'${PREFIX}'_'${date}'.mp3" controls>' >> "${outdir}/index.html"
echo '<p>音声を再生するにはaudioタグをサポートしたブラウザが必要です。</p>' >> "${outdir}/index.html"
echo '</audio>' >> "${outdir}/index.html"
echo '<hr/>' >> "${outdir}/index.html"
