const String BASE_URL = 'https://a67c-102-176-94-203.ngrok.io';

// const String BASE_URL = 'https://apis.propertywatch.io';
const String OTP_URL = '$BASE_URL/api/OTP/createOTP';
const String RESET_OTP_URL = '$BASE_URL/api/OTP/resetOTP';
const String CREATE_USER_URL = '$BASE_URL/api/User/createAccount';
const String RESET_PASSWORD_URL = '$BASE_URL/api/User/resetPassword';
const String AUTH_USER_URL = '$BASE_URL/api/User/authenticate';
const String SERVICE_CHARGE_URL = '$BASE_URL/api/ServiceCharge/serviceCode';
const String CREATE_INVOICE_URL = '$BASE_URL/api/Invoice/createInvoice';
const String INVOICE_STATUS_CHECK_URL = '$BASE_URL/api/Invoice/statusCheck';
const String PAYMENT_HISTORY_URL = '$BASE_URL/api/Invoice/email';
const String VERIFY_SITE_LOCATION_PDF_URL =
    "$BASE_URL/api/VerifySiteBoundaries";
const String ADD_RESPONSE_OBJECT_URL =
    '$BASE_URL/api/Invoice/addResponseObject';
const String TRACK_JOB_URL =
    'http://41.66.204.146:8283/gelis_online_service_live/rest/case_management_service/load_application_milestone_for_tracking_by_job';
const String VERIFY_RATEABLE_VALUE_URL =
    'http://41.66.204.146:7273/epma_service/rest/android_web_service/select_andriod_get_details_of_valuation_number';
const String TITLE_CERTIFICATE_URL =
    'http://41.66.204.146:9293/gelis_online_service_live/rest/maps_service/select_plotted_certificate_details';
const String SITE_POLYGON_URL =
    'http://41.66.204.146:9293/gelis_online_service_live/rest/maps_service/select_convert_from_agg_to_wgs84';
const String TERMS_URL =
    'https://services.propertywatch.io/propertywatch/terms.html';
const String PRIVACY_URL =
    'https://services.propertywatch.io/propertywatch/privacy.html';

//Test token
// const String ACCESS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzeXMiLCJyb2xlcyI6WyJST0xFX0FETUlOIl0sImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODY4Ni9hcGkvbG9naW4iLCJleHAiOjIxMTExMjAwOTh9.KNlOfVJMU__57ltjk5YV5FlCIFhGfu9naEe_IsHKSys";

// const String ACCESS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzeXMiLCJyb2xlcyI6WyJST0xFX0FETUlOIl0sImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODU4NS9hcGkvbG9naW4iLCJleHAiOjIxMDkzMzA0ODN9.o8iVHSH8P8rS5CMIkMw0wDwV3BnP2TtLOoTi6BwkHag";

//Cloud token
const String ACCESS_TOKEN =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzeXMiLCJyb2xlcyI6WyJST0xFX0FETUlOIl0sImlzcyI6Imh0dHA6Ly9hcGlzLnByb3BlcnR5d2F0Y2guaW8vYXBpL2xvZ2luIiwiZXhwIjoyMTEyMjQ5ODcyfQ.lV7SMdMY7WbXP_aOKvvyRAaeFrcKnKSlN_HRXUyfrjQ";

const VERSION = '1.0.5';
