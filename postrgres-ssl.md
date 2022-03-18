

Keycloak Operator version 9

Keycloak + Postgres TLS


RH-SSO ->
  			v1.EnvVar{
					Name:  RhssoDatabaseXAConnectionParamsProperty + "_sslMode",
					Value: sslMode,
				},
				v1.EnvVar{
					Name:  RhssoDatabaseNONXAConnectionParamsProperty + "_sslmode",
					Value: sslMode,
				},


apiVersion: keycloak.org/v1alpha1
kind: Keycloak
metadata:
  name: example-keycloak
  labels:
    app: sso
spec:
  keycloakDeploymentSpec:
    experimental:
      env:
        - name: DB_XA_CONNECTION_PROPERTY_sslMode
          value: "verify-ca"
        - name: DB_CONNECTION_PROPERTY_sslmode
          value: "verify-ca"
      volumes:
        - name: my-ssl-config-map # SSL root certificate
          mountPath: /home/jboss/.postgresql # the file should be named `root.crt`

// e.g. verify-ca or verify-full ...
// https://www.postgresql.org/docs/9.1/libpq-ssl.html


Change RHSSO image and init:

RELATED_IMAGE_RHSSO
RELATED_IMAGE_RHSSO_INIT_CONTAINER

	RhssoCertificatePath                       = "/home/jboss/.postgresql"


Test -> keycloak operator version 9 + Keycloak 15/16 check + JDBC params for SSL


Operator -> YAML -> Subscription:

spec:
  channel: alpha
  installPlanApproval: Manual
  name: rhsso-operator
  source: redhat-operators
  sourceNamespace: openshift-marketplace
  startingCSV: rhsso-operator.7.4.9
  config:
    env:
    - name: RELATED_IMAGE_RHSSO
      value: "registry.redhat.io/rh-sso-7/sso75-openshift-rhel8:7.5"
    - name: RELATED_IMAGE_RHSSO_INIT_CONTAINER
      value: "registry.redhat.io/rh-sso-7/sso7-rhel8-init-container:7.5"
