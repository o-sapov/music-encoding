<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2" xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
  <sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>

  <sch:pattern id="gi">
    <sch:rule context="tei:gi">
      <sch:let name="ident_vals" value="//tei:elementSpec/@ident/string()"/>
      <sch:assert role="error" test="
          some $ident in $ident_vals
            satisfies ($ident = text()/string())">The &lt;<sch:name/>&gt; contains text which is not declared in any &lt;elementSpec&gt;.</sch:assert>
    </sch:rule>
    <sch:p>The text value of &lt;gi&gt; must be equal to at least one value of &lt;elementSpec&gt;/@ident.</sch:p>
  </sch:pattern>

  <sch:pattern id="ident">
    <sch:rule context="tei:ident[@type = 'class']">
      <sch:let name="ident_vals" value="//tei:classSpec[@type = 'atts']/@ident/string()"/>
      <sch:assert role="error" test="
          some $ident in $ident_vals
            satisfies ($ident = text()/string())">The &lt;<sch:name/>&gt; contains text which is not declared in any &lt;classSpec&gt;/@ident.</sch:assert>
      <sch:p>The text value of &lt;ident&gt; must be equal to at least one value of &lt;classSpec&gt;/@ident.</sch:p>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="ptr">
    <sch:rule context="tei:ptr[starts-with(@target, '#')]">
      <sch:let name="div_IDs" value="//tei:div/@xml:id/string()"/>
      <sch:let name="target" value="substring-after(@target, '#')"/>
      <sch:assert role="error" test="
          some $id in $div_IDs
            satisfies ($id = $target)">The &lt;<sch:name/>&gt; points to a &lt;div&gt;/xml:id which wasn't declared.</sch:assert>
    </sch:rule>
  </sch:pattern>


  <sch:pattern id="div">
    <sch:rule context="tei:div">
      <sch:assert role="error" test="@xml:id">The &lt;<sch:name/>&gt; has no @xml:id.</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!--Scheint überflüssig zu sein, da ohnehin von dem Jing geprüft wird-->
  <sch:pattern id="xml_id">
    <sch:rule context="@xml:id">
      <sch:let name="count_index" value="index-of(//@xml:id, .) => count()"/>
      <sch:report role="error" test="
          if ($count_index > 1) then
            true()
          else
            false()">The @<sch:name/>="<sch:value-of select="."/>" is defined more than once.</sch:report>
    </sch:rule>
  </sch:pattern>

</sch:schema>
