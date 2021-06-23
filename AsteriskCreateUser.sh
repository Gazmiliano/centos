#!/bin/bash
template='extension,password,name,voicemail,ringtimer,noanswer,recording,outboundcid,sipname,noanswer_cid,busy_cid,chanunavail_cid,noanswer_dest,busy_dest,chanunavail_dest,mohclass,id,tech,dial,devicetype,user,description,emergency_cid,hint_override,cwtone,recording_in_external,recording_out_external,recording_in_internal,recording_out_internal,recording_ondemand,recording_priority,answermode,intercom,cid_masquerade,concurrency_limit,accountcode,allow,avpf,callerid,canreinvite,context,defaultuser,deny,disallow,dtmfmode,encryption,force_avp,host,icesupport,mailbox,namedcallgroup,namedpickupgroup,nat,outbound_proxy,permit,port,qualify,qualifyfreq,rtcp_mux,secret,sendrpid,sessiontimers,sipdriver,transport,trustrpid,type,videosupport,vmexten,callwaiting_enable,findmefollow_strategy,findmefollow_grptime,findmefollow_grppre,findmefollow_grplist,findmefollow_annmsg_id,findmefollow_postdest,findmefollow_dring,findmefollow_needsconf,findmefollow_remotealert_id,findmefollow_toolate_id,findmefollow_ringing,findmefollow_pre_ring,findmefollow_voicemail,findmefollow_calendar_id,findmefollow_calendar_match,findmefollow_changecid,findmefollow_fixedcid,findmefollow_enabled'

template_user='10000,,10000,novm,0,,,,,,,,,,,default,10000,sip,SIP/10000,fixed,10000,10000,,,,yes,yes,yes,yes,enabled,10,disabled,enabled,10000,3,,,no,"10000 <10000>",no,from-internal,,0.0.0.0/0.0.0.0,,rfc2833,no,no,dynamic,no,10000@device,,,yes,,0.0.0.0/0.0.0.0,5060,yes,60,no,123456,pai,accept,chan_sip,"udp,tcp,tls",yes,friend,inherit,,ENABLED,ringallv2-prim,20,,10000,0,"ext-local,10000,dest",,,0,0,Ring,7,novm,,yes,default,,'

# Get user list
users=( $(asterisk -rx "sip show peers" |  awk '{print $1}') )
unset 'users[${#users[@]}-1]'
unset 'users[0]'

# Get max id
max=${users[0]}
for i in "${users[@]}" ; do	
	i=${i##*/}
    ((i > max)) && max=$i	
done

max=$(($max+1))
template_user=${template_user//10000/$max}

echo $template > /home/extensions.csv
echo $template_user >> /home/extensions.csv

fwconsole bi --type=extensions /home/extensions.csv
fwconsole reload