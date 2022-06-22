### XPath Examples
    //button[contains(., 'Cancel')]

    (//button[@id='dropdownMenu1'])[20]

    //input[@value='Accept Tracking']

    //th[contains(., 'Description')]

    //th[normalize-space(text())='Description']

    //tr[@class='ng-scope' and @ng-repeat='user in users.list']/child::td[position()=3]

    //label[text()='Yes']/Ancestor::tbody/tr[2]/td[1]/a

### Contextual Selectors

    //img    image element

    //img/*[1]    first child of element img

    //ul/child::li    first child 'li' of 'ul'

    //img[1]    first img child

    //img/*[last()]    last child of element img

    //img[last()]    last img child

    //img[last()-1]    second last img child

    //ul[*]    'ul' that has children

### Attribute Selectors


    //img[@id='myId']    image element with @id= 'myId'

    //img[@id!='myId']    image elements with @id not equal to 'myId'

    //img[@name]    image elements that have name attribute

    //*[contains(@id, 'Id')]    element with @id containing

    //*[starts-with(@id, 'Id')]    element with @id starting with

    //*[ends-with(@id, 'Id')]    element with @id ending with

    //*[matches(@id, 'r')]    element with @id matching regex ‘r’

    //*[@name='myName']    image element with @name= 'myName'

    //*[@id='X' or @name='X']    element with @id X or a name X

    //*[@name="N"][@value="v"]    element with @name N & specified @value ‘v’

    //*[@name="N" and @value="v"]    element with @name N & specified @value ‘v’

    //*[@name="N" and not(@value="v")]    element with @name N & not specified @value ‘v’

    //input[@type="submit"]    input of type submit

    //a[@href="url"]​​    anchor with target link 'url'

    //section[//h1[@id='hi']]    returns <section> if it has an <h1> descendant with @id= 'hi'

    //*[@id="TestTable"]//tr[3]//td[2]    cell by row and column

    //input[@checked]    checkbox (or radio button) that is checked

    //a[@disabled]    all 'a' elements that are disabled

    //a[@price > 2.50]    'a' with price > 2.5

### XPath Methods

    //table[count(tr) > 1]    return table with more than 1 row

    //*[.="t"]    element containing text 't' exactly

    //a[contains(text(), "Log Out")]    anchor with inner text containing 'Log Out'

    //a[not(contains(text(), "Log Out"))]    anchor with inner text not containing 'Log Out'

    //a[not(@disabled)]    all 'a' elements that are not disabled

### Axis Navigation

    //td[preceding-sibling::td="t"]    cell immediately following cell containing 't' exactly

    //td[preceding-sibling::td[contains(.,"t")]]    cell immediately following cell containing 't'

    //input/following-sibling::a    'a' following some sibling 'input'

    //a/following-sibling::*    sibling element immediately following 'a'

    //input/preceding-sibling::a    'a' preceding some sibling 'input'

    //input/preceding-sibling::*[1]    sibling element immediately preceding 'input'

    //img[@id='MyId']::parent/*    the parent of image with id

