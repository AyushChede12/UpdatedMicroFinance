package com.microfinance.config;

import com.microfinance.model.BranchModule;
import com.microfinance.model.RelativeModule;
import com.microfinance.model.Statedistricts;
import com.microfinance.model.User;
import com.microfinance.model.states;
import com.microfinance.repository.BranchModuleRepo;
import com.microfinance.repository.RelativeModuleRepo;
import com.microfinance.repository.StateDistrictRepo;
import com.microfinance.repository.Staterepo;
import com.microfinance.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class UserInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BranchModuleRepo branchModuleRepo;

    @Autowired
    private RelativeModuleRepo relativeModuleRepo;

    @Autowired
    private Staterepo stateRepo;

    @Autowired
    private StateDistrictRepo stateDistrictRepo;

    @Autowired
    private com.microfinance.repository.CustomerRepo customerRepo;

    @Autowired
    private com.microfinance.repository.CreateSavingAccountRepo createSavingAccountRepo;

    @Autowired
    private javax.sql.DataSource dataSource;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("=== DATA INITIALIZER RUNNING ===");

        // ========== MIS Module Database Schema Auto-Initialization ==========
        try (java.sql.Connection conn = dataSource.getConnection();
             java.sql.Statement stmt = conn.createStatement()) {

            String[] alterQueries = {
                "ALTER TABLE misdepositpm ADD COLUMN lock_in_months INT DEFAULT 0",
                "ALTER TABLE misdepositpm ADD COLUMN payout_day INT DEFAULT 1",
                "ALTER TABLE misdepositpm ADD COLUMN premature_closure_penalty_rate DECIMAL(5,2) DEFAULT 1.00",
                "ALTER TABLE MISDepositPM ADD COLUMN lock_in_months INT DEFAULT 0",
                "ALTER TABLE MISDepositPM ADD COLUMN payout_day INT DEFAULT 1",
                "ALTER TABLE MISDepositPM ADD COLUMN premature_closure_penalty_rate DECIMAL(5,2) DEFAULT 1.00",
                "ALTER TABLE misdepositpm ADD COLUMN lockInMonths INT DEFAULT 0",
                "ALTER TABLE misdepositpm ADD COLUMN payoutDay INT DEFAULT 1",
                "ALTER TABLE misdepositpm ADD COLUMN prematureClosurePenaltyRate DECIMAL(5,2) DEFAULT 1.00"
            };
            for (String q : alterQueries) {
                try {
                    stmt.executeUpdate(q);
                } catch (Exception ignored) {
                    // Column already exists or table name case difference, ignore
                }
            }

            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS mis_policy (" +
                "id BIGINT NOT NULL AUTO_INCREMENT, " +
                "policy_number VARCHAR(50) NOT NULL UNIQUE, " +
                "customer_id VARCHAR(100), " +
                "customer_name VARCHAR(255), " +
                "plan_id BIGINT, " +
                "plan_name VARCHAR(255), " +
                "principal_amount DECIMAL(15,2) NOT NULL, " +
                "interest_rate DECIMAL(5,2) NOT NULL, " +
                "tenure_months INT NOT NULL, " +
                "start_date DATE NOT NULL, " +
                "maturity_date DATE NOT NULL, " +
                "monthly_payout_amount DECIMAL(15,2), " +
                "payout_day INT DEFAULT 1, " +
                "lock_in_months INT DEFAULT 0, " +
                "status VARCHAR(50) DEFAULT 'ACTIVE', " +
                "linked_account_id VARCHAR(100), " +
                "nominee_name VARCHAR(255), " +
                "nominee_relation VARCHAR(100), " +
                "renewed_from_policy_id BIGINT, " +
                "add_investment_id BIGINT, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, " +
                "PRIMARY KEY (id)" +
            ")");

            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS mis_payout_ledger (" +
                "id BIGINT NOT NULL AUTO_INCREMENT, " +
                "policy_id BIGINT NOT NULL, " +
                "payout_date DATE NOT NULL, " +
                "interest_amount DECIMAL(15,2), " +
                "tds_deducted DECIMAL(15,2) DEFAULT 0.00, " +
                "net_paid DECIMAL(15,2), " +
                "status VARCHAR(50) DEFAULT 'PAID', " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "PRIMARY KEY (id)" +
            ")");

            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS mis_closure_audit (" +
                "id BIGINT NOT NULL AUTO_INCREMENT, " +
                "policy_id BIGINT NOT NULL, " +
                "closure_type VARCHAR(50), " +
                "closure_date DATE, " +
                "penalty_applied DECIMAL(15,2) DEFAULT 0.00, " +
                "refund_amount DECIMAL(15,2), " +
                "reason VARCHAR(500), " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "PRIMARY KEY (id)" +
            ")");

            System.out.println("=== MIS DATABASE SCHEMA INITIALIZED SUCCESSFULLY ===");
        } catch (Exception e) {
            System.err.println("MIS DB Init Warning: " + e.getMessage());
        }

        // ========== 1. Admin User ==========
        try {
            if (userRepository.findByUsername("admin") == null) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword("admin123");
                admin.setRoles(Arrays.asList("ADMIN"));
                userRepository.save(admin);
                System.out.println("Default admin user created: admin / admin123");
            } else {
                System.out.println("Admin user already exists: " +
                        userRepository.findByUsername("admin").getPassword());
            }
        } catch (Exception e) {
            System.err.println("Error seeding user: " + e.getMessage());
        }

        // ========== 2. Branch Module ==========
        try {
            long branchCount = branchModuleRepo.count();
            if (branchCount == 0) {
                String[][] branches = {
                    {"BR001", "MAIN BRANCH", "2020-01-01", "Main Road, Mumbai", "400001", "Maharashtra"},
                    {"BR002", "PUNE BRANCH", "2020-06-01", "MG Road, Pune", "411001", "Maharashtra"},
                    {"BR003", "NASHIK BRANCH", "2021-01-01", "CBS Road, Nashik", "422001", "Maharashtra"},
                    {"BR004", "AURANGABAD BRANCH", "2021-06-01", "Station Road, Aurangabad", "431001", "Maharashtra"},
                    {"BR005", "NAGPUR BRANCH", "2022-01-01", "Sitabuldi, Nagpur", "440001", "Maharashtra"},
                };
                for (String[] b : branches) {
                    BranchModule branch = new BranchModule();
                    branch.setBranchCode(b[0]);
                    branch.setBranchName(b[1]);
                    branch.setOpeningDate(b[2]);
                    branch.setAddress(b[3]);
                    branch.setPin(b[4]);
                    branch.setState(b[5]);
                    branchModuleRepo.save(branch);
                }
                System.out.println("Seeded " + branches.length + " branches.");
            } else {
                System.out.println("Branches already exist: " + branchCount);
            }
        } catch (Exception e) {
            System.err.println("Error seeding branches: " + e.getMessage());
        }

        // ========== 3. Relative / Relation Module ==========
        try {
            long relCount = relativeModuleRepo.count();
            if (relCount == 0) {
                String[] relations = {
                    "SELF", "FATHER", "MOTHER", "SPOUSE", "SON", "DAUGHTER",
                    "BROTHER", "SISTER", "GRAND FATHER", "GRAND MOTHER",
                    "UNCLE", "AUNT", "NEPHEW", "NIECE", "OTHER"
                };
                for (String rel : relations) {
                    RelativeModule rm = new RelativeModule();
                    rm.setRelation(rel);
                    relativeModuleRepo.save(rm);
                }
                System.out.println("Seeded " + relations.length + " relations.");
            } else {
                System.out.println("Relations already exist: " + relCount);
            }
        } catch (Exception e) {
            System.err.println("Error seeding relations: " + e.getMessage());
        }

        // ========== 4. States ==========
        try {
            long stateCount = stateRepo.count();
            if (stateCount == 0) {
                String[][] stateList = {
                    {"1", "Andhra Pradesh"}, {"2", "Arunachal Pradesh"}, {"3", "Assam"},
                    {"4", "Bihar"}, {"5", "Chhattisgarh"}, {"6", "Goa"},
                    {"7", "Gujarat"}, {"8", "Haryana"}, {"9", "Himachal Pradesh"},
                    {"10", "Jharkhand"}, {"11", "Karnataka"}, {"12", "Kerala"},
                    {"13", "Madhya Pradesh"}, {"14", "Maharashtra"}, {"15", "Manipur"},
                    {"16", "Meghalaya"}, {"17", "Mizoram"}, {"18", "Nagaland"},
                    {"19", "Odisha"}, {"20", "Punjab"}, {"21", "Rajasthan"},
                    {"22", "Sikkim"}, {"23", "Tamil Nadu"}, {"24", "Telangana"},
                    {"25", "Tripura"}, {"26", "Uttar Pradesh"}, {"27", "Uttarakhand"},
                    {"28", "West Bengal"}, {"29", "Delhi"}, {"30", "Jammu And Kashmir"}
                };
                for (String[] s : stateList) {
                    states st = new states();
                    st.setStateId(Integer.parseInt(s[0]));
                    st.setStateName(s[1]);
                    stateRepo.save(st);
                }
                System.out.println("Seeded " + stateList.length + " states.");
            } else {
                System.out.println("States already exist: " + stateCount);
            }
        } catch (Exception e) {
            System.err.println("Error seeding states: " + e.getMessage());
        }

        // ========== 5. Districts ==========
        try {
            long districtCount = stateDistrictRepo.count();
            if (districtCount == 0) {
                // Maharashtra (stateId=14)
                String[] maharashtraDistricts = {
                    "Mumbai", "Pune", "Nashik", "Nagpur", "Aurangabad", "Thane",
                    "Solapur", "Kolhapur", "Ahmednagar", "Amravati", "Jalgaon",
                    "Satara", "Ratnagiri", "Nanded", "Sangli", "Osmanabad",
                    "Latur", "Jalna", "Parbhani", "Buldhana", "Akola", "Wardha",
                    "Yavatmal", "Chandrapur", "Gadchiroli", "Bhandara", "Gondia",
                    "Washim", "Hingoli", "Raigad", "Sindhudurg", "Dhule"
                };
                for (String d : maharashtraDistricts) {
                    Statedistricts sd = new Statedistricts();
                    sd.setStateId(14);
                    sd.setStateName("Maharashtra");
                    sd.setDistrictName(d);
                    stateDistrictRepo.save(sd);
                }
                // Gujarat (stateId=7)
                String[] gujaratDistricts = {
                    "Ahmedabad", "Surat", "Vadodara", "Rajkot", "Bhavnagar",
                    "Gandhinagar", "Junagadh", "Jamnagar", "Anand", "Mehsana"
                };
                for (String d : gujaratDistricts) {
                    Statedistricts sd = new Statedistricts();
                    sd.setStateId(7);
                    sd.setStateName("Gujarat");
                    sd.setDistrictName(d);
                    stateDistrictRepo.save(sd);
                }
                // Uttar Pradesh (stateId=26)
                String[] upDistricts = {
                    "Lucknow", "Agra", "Varanasi", "Kanpur", "Allahabad",
                    "Ghaziabad", "Noida", "Meerut", "Bareilly", "Moradabad"
                };
                for (String d : upDistricts) {
                    Statedistricts sd = new Statedistricts();
                    sd.setStateId(26);
                    sd.setStateName("Uttar Pradesh");
                    sd.setDistrictName(d);
                    stateDistrictRepo.save(sd);
                }
                // Karnataka (stateId=11)
                String[] karnatakaDistricts = {
                    "Bengaluru", "Mysuru", "Hubli", "Mangaluru", "Belgaum",
                    "Davanagere", "Bellary", "Bijapur", "Shimoga", "Tumkur"
                };
                for (String d : karnatakaDistricts) {
                    Statedistricts sd = new Statedistricts();
                    sd.setStateId(11);
                    sd.setStateName("Karnataka");
                    sd.setDistrictName(d);
                    stateDistrictRepo.save(sd);
                }
                // Tamil Nadu (stateId=23)
                String[] tnDistricts = {
                    "Chennai", "Coimbatore", "Madurai", "Tiruchirappalli", "Salem",
                    "Tirunelveli", "Erode", "Vellore", "Thoothukudi", "Dindigul"
                };
                for (String d : tnDistricts) {
                    Statedistricts sd = new Statedistricts();
                    sd.setStateId(23);
                    sd.setStateName("Tamil Nadu");
                    sd.setDistrictName(d);
                    stateDistrictRepo.save(sd);
                }
                // Delhi (stateId=29)
                String[] delhiDistricts = {
                    "Central Delhi", "East Delhi", "New Delhi", "North Delhi", "North East Delhi",
                    "North West Delhi", "Shahdara", "South Delhi", "South East Delhi",
                    "South West Delhi", "West Delhi"
                };
                for (String d : delhiDistricts) {
                    Statedistricts sd = new Statedistricts();
                    sd.setStateId(29);
                    sd.setStateName("Delhi");
                    sd.setDistrictName(d);
                    stateDistrictRepo.save(sd);
                }
                System.out.println("Seeded districts for Maharashtra, Gujarat, UP, Karnataka, Tamil Nadu, Delhi.");
            } else {
                System.out.println("Districts already exist: " + districtCount);
            }
        } catch (Exception e) {
            System.err.println("Error seeding districts: " + e.getMessage());
        }

        System.out.println("=== DATA INITIALIZER COMPLETED ===");
    }
}
