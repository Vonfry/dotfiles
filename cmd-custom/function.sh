function _current_epoch()
{
   echo $( $(date +%s) / 60 / 60 / 24 )
}
