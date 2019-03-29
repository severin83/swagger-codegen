#!/bin/sh

SCRIPT="$0"

while [ -h "$SCRIPT" ] ; do
  ls=`ls -ld "$SCRIPT"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    SCRIPT="$link"
  else
    SCRIPT=`dirname "$SCRIPT"`/"$link"
  fi
done

if [ ! -d "${APP_DIR}" ]; then
  APP_DIR=`dirname "$SCRIPT"`/..
  APP_DIR=`cd "${APP_DIR}"; pwd`
fi

executable="./modules/swagger-codegen-cli/target/swagger-codegen-cli.jar"

if [ ! -f "$executable" ]
then
  mvn clean package
fi

# if you've executed sbt assembly previously it will use that instead.
export JAVA_OPTS="${JAVA_OPTS} -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties"

echo "Typescript Petstore API client (default)"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -o samples/client/petstore/typescript-angular-v2/default --additional-properties ngVersion=2"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (npm setting)"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -c bin/typescript-petstore-npm.json -o samples/client/petstore/typescript-angular-v2/npm --additional-properties ngVersion=2"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (with interfaces generated)"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -o samples/client/petstore/typescript-angular-v2/with-interfaces -D withInterfaces=true --additional-properties ngVersion=2"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (with interfaces generated and v4.3 HttpClientModule)"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -o samples/client/petstore/typescript-angular-v4.3/with-interfaces -D withInterfaces=true --additional-properties ngVersion=4.3"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (with interfaces generated and v5 HttpClientModule)"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -o samples/client/petstore/typescript-angular-v5/with-interfaces -D withInterfaces=true --additional-properties ngVersion=5"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (v4 { Adding InjectionToken Over OpaqueToken })"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -c bin/typescript-petstore-npm.json -o samples/client/petstore/typescript-angular-v4/npm --additional-properties ngVersion=4"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (v4.3 { Adding HttpClientModule over HttpModule })"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -c bin/typescript-petstore-npm.json -o samples/client/petstore/typescript-angular-v4.3/npm --additional-properties ngVersion=4.3"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (v5 { Uses latest version of ng-packagr })"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -c bin/typescript-petstore-npm.json -o samples/client/petstore/typescript-angular-v5/npm --additional-properties ngVersion=5"
java $JAVA_OPTS -jar $executable $ags

echo "Typescript Petstore API client (v6 { Uses RxJS version 6 })"
ags="$@ generate -i modules/swagger-codegen/src/test/resources/2_0/petstore.yaml -l typescript-angular -c bin/typescript-petstore-npm.json -o samples/client/petstore/typescript-angular-v6/npm --additional-properties ngVersion=6"
java $JAVA_OPTS -jar $executable $ags
