*** Settings ***
Documentation    Test suite for Market Readiness Assessment (MRA) Grant form

Suite Setup     Navigate To MRA Grant form
Suite Teardown  Close All Browsers

Resource    ${EXECDIR}/Tests/mra_grant_test/grants_resource.robot
