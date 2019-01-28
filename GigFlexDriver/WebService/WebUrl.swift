//
//  WebUrl.swift
//
//
//  Created by khim singh on 16/05/17.
//  Copyright © 2017 eSoft. All rights reserved.
//

import Foundation
//static variable
  let baseUrlWithPort8085 = "http://18.223.158.6:8085/"
  let baseUrl = "http://18.223.158.6:8762/"
  let regBaseUrl = "http://192.168.0.2:8085/"
  let user = "userservice/"
  let organizationUrl = "organizationservice/"
  let workerserviceUrl = "workerservice/"
//=============================================================================================================================================
// Web Service for all Registation pages and forget pages
let getAllIndustryUrl = URL(string: baseUrlWithPort8085 + user + "getAllIndustryMaster")
let registerUrl = URL(string: baseUrlWithPort8085 + user + "userRegistration")
let forgotUrl =  baseUrlWithPort8085 + user + "sendForgetPasswordLink/"
//=============================================================================================================================================
//worker
let getAllOrganizationsUrl = URL(string: baseUrlWithPort8085 + user + "getAllOrganizations")
//=============================================================================================================================================
// All Web services for login page
let loginUrl = URL(string: baseUrl + "auth")
let getWorkerTypeUrl = baseUrlWithPort8085 +  user + "workerType/"
let getUserCodeUrl = baseUrlWithPort8085 + user + "getUser/"
//=============================================================================================================================================
// Owner DashBoard
//let listPendingUrl = URL(string: baseUrl + organizationUrl + "getAllWAS")
let listPendingUrl = baseUrl + workerserviceUrl + "getPendingWorkerForApproval/"
let verifyWorkerUrl = URL (string: baseUrl + organizationUrl + "verifySingleEmployee")
let workerApprovalUrl = baseUrl + organizationUrl + "getWorkApprovalStatusByOrganizationCode/"
let updateWASApprovelUrl = baseUrl + organizationUrl + "updateWAS/"
let getWorkerScheduleRequestURL = baseUrl + workerserviceUrl + "getWorkerScheduleRequestByOrganizationCodeByPage/"
let getTradeShiftUrl = baseUrl + workerserviceUrl + "getTradeShiftDetailtByOrganizationCode/"
let approvalChangeAssignToWorkerScheduleRequestUrl = URL(string: baseUrl + workerserviceUrl + "approvalChangeAssignToWorkerScheduleRequest")
// profile ViewController
let getOrganizationByOrgCodeUrl = baseUrl + organizationUrl + "getOrganizationByOrgCode/"
let updateOrganizationUrl = baseUrl + organizationUrl + "updateOrganization/"
let getOrganizationWorkingLocationHoursByOrgCodeByPageUrl = baseUrl + organizationUrl + "getOrganizationWorkingLocationHoursByOrgCodeByPage/"
let workerDelByOwnerUrl = baseUrl + workerserviceUrl + "deleteWorker/"
//worker Dashboard
let userProfileIconUrl = "http://18.223.158.6:8091/superadminservice/downloadFile/"
let uploadFileUrl = URL(string: "http://18.223.158.6:8091/superadminservice/uploadFile")
let workerListUrl = baseUrl + workerserviceUrl + "getWorkerByWorkerCode/"
//let departmentMasterUrl = URL(string: baseUrl + organizationUrl + "departmentMaster")
let updateWorkerUrl = baseUrl + organizationUrl + "updateWorker/"
let deleteWorkerUrl = baseUrl + workerserviceUrl + "deleteWorkerByWorkerCode/"
// department web url
let getDepartmentMasterByOrgCodeByPageUrl = baseUrl + organizationUrl + "getDepartmentMasterByOrgCodeByPage/"
let departmentMasterUrl = URL(string: baseUrl + organizationUrl + "departmentMaster")
let updateDepartmentMasterUrl = baseUrl + organizationUrl + "updateDepartmentMaster/"
// Schedule Request
let getWorkerScheduleRequestByOrganizationCodeByPageUrl = baseUrl + workerserviceUrl + "getWorkerScheduleRequestByOrganizationCodeByPage/"
// Standard Shift
let workingLocationByOrgCodeUrl = baseUrl + organizationUrl + "workingLocationByOrgCode/"
let getAllOrganizationWorkerShiftByLocationCodeByPageUrl = baseUrl + organizationUrl + "getAllOrganizationWorkerShiftByLocationCodeByPage/"
// skillset
let getSkillsByOrganizationCodeUrl = baseUrl + organizationUrl + "getSkillsByOrganizationCode/"
let getSkillsByIndustryAndOrganizationCodeUrl = baseUrl + organizationUrl + "getSkillsByIndustryAndOrganizationCode/"
let saveOrganizationSkillUrl = URL(string: baseUrl + organizationUrl + "saveOrganizationSkill")
let saveSkillMasterUrl = URL(string: baseUrl + organizationUrl + "saveSkillMaster")
