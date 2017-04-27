#!/usr/bin/env node

var external_user_id = '9af3e76f7a975a2d96061d1f83b344380f049632';
var external_course_id = '35250fa14b01bf52e3253343bdf23b5c3b9ff3fb';
var roles = 'Learner';
var consumer_key = 'saltlakecommunity.canvas.com';
var consumer_base_url = 'slcc.instructure.com';

function launch(id) {

	var apiUrl = "/highlander/api/v1/links/"+id+"/launch?externaluserid="+external_user_id+"&externalcourseid="+external_course_id+"&roles="+roles+"&consumerkey="+consumer_key;

	//fix for TPLMS-1775
	if ((typeof oauth_version !== 'undefined') && (typeof oauth_timestamp !== 'undefined') && (typeof oauth_signature_method !== 'undefined') &&
		(typeof oauth_signature !== 'undefined') && (typeof oauth_nonce !== 'undefined') && (typeof oauth_consumer_key !== 'undefined') && (typeof oauth_callback !== 'undefined')) {

		apiUrl = "/highlander/api/v1/links/"+id+"/launch?externaluserid="+external_user_id+
														"&externalcourseid="+external_course_id+
														"&roles="+roles+
														"&consumerkey="+consumer_key+
														"&oauth_version="+oauth_version+
														"&oauth_timestamp="+oauth_timestamp+
														"&oauth_signature_method="+oauth_signature_method+
														"&oauth_signature="+oauth_signature+
														"&oauth_nonce="+oauth_nonce+
														"&oauth_consumer_key="+oauth_consumer_key+
														"&oauth_callback="+oauth_callback;
	}

	if (external_parent_course_id) {
		apiUrl = apiUrl + "&externalparentcourseid="+external_parent_course_id;
	}

	if (consumer_base_url) {
		apiUrl = apiUrl + "&baseurl="+consumer_base_url;
	}

	$.ajax({
		cache: false,
		url : apiUrl,
		type : "GET",
		contentType : "application/json;charset=utf-8",
		success : function(result) {
			$('#ltilaunchform').empty();

			$.each(result.parameters, function() {
				$('<input>').attr({type: 'hidden', value: this.value, name: this.key}).appendTo('#ltilaunchform');
			});

			$('#ltilaunchform').attr('action', result.launch_url);
			$('#ltilaunchform').attr('target', '_blank')
			$('#ltilaunchform').submit();
		},
		error : function (xhr, ajaxOptions, thrownError) {
			$('#tools-error-heading').text('An error occurred');
			$('#tools-error-description').text('Unable to access the links for your course.');
			$('#tools-error').show();
		}
	});
}

launch(105);
