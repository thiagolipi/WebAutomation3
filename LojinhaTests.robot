*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL_lojinha}    http://165.227.93.41/lojinha-web/v2/
${input_user}    //input[@id="usuario"]
${input_password}    //input[@id="senha"]
${button_submit}    //button[@type="submit"]
${button_addProduct}    //a[@href="http://165.227.93.41/lojinha-web/v2/produto/novo"]
${input_productName}    //input[@id="produtonome"]
${input_productValue}    //input[@id="produtovalor"]
${input_productColor}    //input[@id="produtocores"]
${button_save}    //button[@type="submit"]

*** Keywords ***
User access the Lojinha's website
    Open Browser    http://165.227.93.41/lojinha-web/v2/    chrome
    Maximize Browser Window

Log in
    Input Text    ${input_user}    admin
    Input Text    ${input_password}    admin
    Click Element    ${button_submit}

Access the Add Product page
    Click Element    ${button_addProduct}

Write the product's name
    Wait Until Element Is Visible    ${input_productName}
    Input Text    ${input_productName}    Canoa

Write a valid value
    Input Text    ${input_productValue}    300000

Write a value greater than R$ 7.000,00
    Input Text    ${input_productValue}    700001

Write the product's colors
    Input Text    ${input_productColor}    Marrom

Submit the addition of the product
    Click Element    ${button_save}

Confirm error
    Element Text Should Not Be    css=.toast.rounded    Produto adicionado com sucesso
    Close Browser

Confirm success
    Element Text Should Be    css=.toast.rounded    Produto adicionado com sucesso
    Close Browser

*** Test Cases ***
TC1: Adding a valid product
    Given User access the Lojinha's website
    And Log in
    When Access the Add Product page
    And Write the product's name
    And Write a valid value
    And Write the product's colors
    And Submit the addition of the product
    Then Confirm success

TC2: Adding a product with a value greater than R$ 7000.00
    Given User access the Lojinha's website
    And Log in
    When Access the Add Product page
    And Write the product's name
    And Write a value greater than R$ 7.000,00
    And Write the product's colors
    And Submit the addition of the product
    Then Confirm error

TC3: Adding a product without writing it's name
    Given User access the Lojinha's website
    And Log in
    When Access the Add Product page
    And Write a valid value
    And Write the product's colors
    And Submit the addition of the product
    Then Confirm success    #intentional fake success

TC4: Adding a product without writing it's value
    Given User access the Lojinha's website
    And Log in
    When Access the Add Product page
    And Write the product's name
    And Write the product's colors
    And Submit the addition of the product
    Then Confirm error

TC5: Adding a product without writing it's color
    Given User access the Lojinha's website
    And Log in
    When Access the Add Product page
    And Write the product's name
    And Write a valid value
    And Submit the addition of the product
    Then Confirm success    #intentional fake success