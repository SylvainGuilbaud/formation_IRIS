/// <pre>
/// Copyright (c) Alex Woodhead 2023
/// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
/// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
/// License MIT
/// Source: https://github.com/alexatwoodhead/EnsHelper
/// Version: 1.0
/// </pre>
/// This helper class extends the User Interface of the Management Portal view.
/// Location: Information section of Producton Instance Configuration Properties
/// It adds a new TextArea dispalying Host Request Types the Host expects to recieve
/// It adds a new TestArea displaying Host Response Types returned by the Host Type
/// To use simply add this class name to the Extends list of any custom:
/// <ul>
/// <li>Business Service</li>
/// <li>Business Process</li>
/// <li>Business Operation</li>
/// </ul>
/// Business Service example
/// <example>
/// Class myService extends (Ens.BusinessService, alwo.EnsHelper.HostRequestResponseInfo)
/// {
/// }
/// </example>
/// Business Process example.
/// <example>
/// Class myBusinessProcess extends (Ens.BusinessProcess, alwo.EnsHelper.HostRequestResponseInfo)
/// {
/// }
/// </example>
/// Business Operation example:
/// <example>
/// Class myOperation extends (Ens.BusinessOperation, alwo.EnsHelper.HostRequestResponseInfo)
/// {
/// }
/// </example>
Class alwo.EnsHelper.HostRequestResponseInfo Extends Ens.Host [ Abstract ]
{

Property RequestTypes As %String(MAXLEN = 4000) [ InitialExpression = {..GetRequestTypes()}, Transient ];

Property ResponseTypes As %String(MAXLEN = 4000) [ InitialExpression = {..GetResponseTypes()}, Transient ];

Parameter SETTINGS = "RequestTypes:Info,ResponseTypes:Info";

ClassMethod GetRequestTypes()
{
	set ret=""
	set messageTypes=..GetRequestClassList()
	quit:messageTypes="" ret
	for i=1:1:$LL(messageTypes) {
		set ret=ret_$C(13,10)_$LI(messageTypes,i)
	}
	quit ret
}

ClassMethod GetResponseTypes()
{
	set ret=""
	set messageTypes=..GetResponseClassList()
	quit:messageTypes="" ret
	for i=1:1:$LL(messageTypes) {
		set ret=ret_$C(13,10)_$LI(messageTypes,i)
	}
	quit ret
}

}
