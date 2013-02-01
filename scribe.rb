require 'savon'

wsdl_url = "http://wsdl_url";
username = "username";
password = "password";
pageId = 123456;

client = Savon.client(wsdl: + wsdl_url)

response = client.call(:login, message: {username: username, password: password } )
token = response.body[:login_response][:login_return]
response = client.call(:get_page, message: { token: token, pageId: pageId } )

# Get the current content of the page
page = response.body[:get_page_response][:get_page_return]

# Prepare the new content
content ="
<table>
	<tbody>
		<tr>
		<th>Fake</th>
		<th>Fake</th>
		<th>Fake</th>
		</tr>
		<tr>
		<td>Fake</td>
		<td>Content</td>
		<td>Here</td>
		</tr>
		<tr><td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		</tr>
	</tbody>
</table>
"
# Replace the content
page[:content] = content;
# Store the new content
client.call(:store_page, message: { token: token, page: page })

