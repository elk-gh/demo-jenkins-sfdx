### Demo CI DX - Dev Week

## Prerequisitos

- [Developer Org](https://developer.salesforce.com/signup)
- [Migration Toolkit](https://developer.salesforce.com/docs/atlas.en-us.daas.meta/daas/forcemigrationtool_install.htm)
- [Java y ANT](https://developer.salesforce.com/docs/atlas.en-us.daas.meta/daas/forcemigrationtool_prereq.htm)
- [Jenkins](https://jenkins.io/download/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Salesforce Extension Pack](https://marketplace.visualstudio.com/items?itemName=salesforce.salesforcedx-vscode)
- [Salesforce CLI](https://developer.salesforce.com/tools/sfdxcli)
- [OpenSSL](https://sourceforge.net/projects/gnuwin32/files/openssl/0.9.8h-1/openssl-0.9.8h-1-bin.zip/download)

## Demo
- Descargar openSSL en C:\openssl de https://sourceforge.net/projects/gnuwin32/files/openssl/
- Descomprimir y cambiar el nombre de la carpeta a openssl
- Copiar y pegar la carpeta openssl a C:\
- Setear variable de entorno (System Variable)
  ```
  OPENSSL_CONF=C:\openssl\share\openssl.cnf
  ```
- Ir a C:\openssl\bin y ejecutar CMD desde ahí
- Generar llave privada RSA
  ```
  openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
  ```
- Crear archivo key del archivo server.pass.key 
  ```
    openssl rsa -passin pass:x -in server.pass.key -out server.key
  ```
- Generar el Certificate Signing Request.
  ```
    openssl req -new -key server.key -out server.csr
  ```
- Generar el Certificado SSL
  ```
      openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt
  ```
- Crear Aplicación Conectada
  ``` 
      Name: Jenkins
      Callback URL: http://localhost:1717/OauthRedirect
      Selected OAuth Scopes:
      - Access your basic information (id, profile, email, address, phone)
      - Access and manage your data (api)
      - Provide access to your data via the Web (web)
      - Perform requests on your behalf at any time (refresh_token, offline_access)
      Check Use digital signatures
      Choose File: server.crt en C:\openssl\bin
      Click en Manage
      Click en Edit Policies
      Permitted Users: Admin approved user are pre-authorized
      Click Save
      Click Manage Profiles
      Select System Administrator
      Click Save
  ```
- Validar JWT Login Flow desde C:\openssl\bin
  ```
    sfdx force:auth:jwt:grant --clientid {ADD_YOUR_CLIENT_ID} --jwtkeyfile server.key --username {ADD_YOUR_USERNAME} --instanceurl https://login.salesforce.com --setdefaultdevhubusername
  ```
  ```
    - clientid  :- provide Consumer Key
    - jwtkeyfile :- Absolute path to the location where you generated your OpenSSL server.key file
    - instanceurl :-provide instanceurl if you are using sandbox.
    - setdefaultdevhubusername :- Set Default dev hub User Name.
  ```
- Ir a Jenkins
- Configurar Server.key en el pluggin
  ```
    - Jenkins
    - Credentials
    - System
    - Global credentials (unrestricted) 
    - Add Credentials
    - Kind: Secret File
    - Seleccionar server.key en C:\openssl\bin
  ```
- Crear Custom App Toolbet 
  ```
  TODO
  ```
- Establecer las variables de Entorno del Sistema para Jenkins en el PC 
  ```
    HUB_ORG_DH: Username for the Dev Hub Org.
    SFDC_HOST_DH: Login URL of the Salesforce instance which is hosting the Hub. Example: https://login.salesforce.com
    CONNECTED_APP_CONSUMER_KEY_DH : Consumer key obtained in the connected app
    JWT_CRED_ID_DH: The credentials ID for the private  key file (Se obtiene desde Jenkins)
        - Login en Jenkins
        - Ubicar las credenciales globales (Credentials --> System --> Global Credentials --> ServerKey)
        - Update (Extraer ID del file y utilizarlo en la variable de entorno JWT_CRED_ID_DH)
   ```
- Configurar Jenkins
  ```
    - Jenkins --> New Item
    - Definir un nombre
    - Seleccionar Categoria Multibrach PipeLine
    - Branch sources --> Seleccionar Adicionar un item (TODO)
    - Single repository & branch --> Indicar la URL del repositorio
    - Especificar la rama si es requerido
    - Guardar 
  ```  
- Ir a la pestaña del Item creado
- En la lista que aparece dar click en el nombre del ultimo build
- Reinciar el equipo
- Retornar a Jenkins
- Ir al repositorio 
- Selecionar la opcion "Build Now"

TODO:
-Toolbet
-Webhooks
-

Ver: 
- [Develop an App with Salesforce CLI and Source Control](https://trailhead.salesforce.com/en/content/learn/projects/develop-app-with-salesforce-cli-and-source-control)
- [Continuous Integration|Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ci.htm)
- [Continuous Integration Using Jenkins with SalesforceDX | JWT-Based Flow](http://amitsalesforce.blogspot.com/2019/01/continuous-integration-using-jenkins-with-salesforceDx.html)
 
## Enlaces Adicionales
  - [Dude, where's my permission?](http://www.salesforcehacker.com/2013/05/dude-wheres-my-permission.html)
  - [Metadata Coverage](https://developer.salesforce.com/docs/metadata-coverage)








