ruleset io.picolabs.did-o-ui {
  meta {
    use module io.picolabs.wrangler alias wrangler
    use module io.picolabs.did-o alias didx
    use module html
    shares index, diddoc
  }
  global {
    elide = function(did){
      did_length = did.length()
      did_length < 30 => did |
      did.substr(0,25) + "…"
    }
    index = function(){
      html:header("DIDComm2 agent","")
      + <<<h1>Agent #{meta:eci}</h1>
<h2>Child picos</h2>
<ul>
#{wrangler:children().map(function(c){
<<<li>#{c.encode()}</li>
>>
}).join("")}</ul>
<h2>DIDDocs</h2>
<ul>
#{didx:didDocs().keys().map(function(k){
<<<li title="#{k}"><a href="diddoc.html?did=#{k}">#{k.elide()}</a></li>
>>}).join("")}</ul>
>>
      + html:footer()
    }
    diddoc = function(did){
      dd = didx:didDocs().get(did).encode()
      short_did = did.elide()
      css = <<<style>textarea{height:30em;width:60%;}</style>
>>
      html:header("DIDDoc for "+short_did,css)
      + <<<h1>DIDDoc for #{short_did}</h1>
<textarea id="diddoc" wrap="off" readonly></textarea>
<script type="text/javascript">
document.getElementById("diddoc").value
= JSON.stringify(JSON.parse('#{dd}'),null,2);
</script>
>>
      + html:footer()
    }
  }
}
