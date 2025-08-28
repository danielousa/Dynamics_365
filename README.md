# Farm Management Project
# Context

In a world increasingly driven by data and automation, the efficient management of agricultural operations, particularly in livestock farming, has become a critical need. This necessity is amplified in modern cattle farming, where the ability to monitor and manage milk production and animal health is directly linked to profitability and sustainability. Within this context, the development of a specialized extension for Business Central focused on farm management emerges as a strategic and essential solution.
The significance of this extension lies in its potential to streamline and enhance complex processes associated with farm operations, particularly in integrating milk production data and cattle management within a single, centralized system. Traditionally, these processes have been managed through disparate systems, often leading to inefficiencies and data inconsistencies. This extension provides a unified platform that enables farm managers to oversee all aspects of their operations, from tracking individual cow health and milk yields to managing finances and reporting, thereby ensuring a comprehensive view of farm performance.
Through this extension, farm managers can easily access critical information such as daily milk production, cow health records, and operational analytics. This data integration not only aids in day-to-day decision-making but also supports long-term strategic planning, helping farmers optimize production and improve the overall health of their herd. For businesses, this extension provides a robust toolset that supports compliance with industry standards and enhances operational efficiency.
The decision to create a dedicated farm management extension for Business Central reflects the need to adapt to the evolving demands of the agricultural sector, providing innovative solutions that simplify and improve the management of livestock farming operations.

# Objectives
Purpose of the System (context and objectives):

To develop a farm management extension for Business Central aimed at improving the management of cattle and milk production. This extension will incorporate various tasks and functionalities (e.g., monitoring milk yields, tracking cow health, managing financials, generating reports, etc.) to streamline interactions between farm managers and the system, thereby enhancing operational efficiency and decision-making processes.

# Stakeholders
Stakeholders (client and users) and How the System Affects Their Lives:

This farm management extension is designed for use by farm managers and agricultural business owners who need a comprehensive tool for overseeing livestock and milk production. Users will be able to monitor real-time data on cow health, track milk production trends, and manage farm-related financials all within a single platform. The extension also allows for seamless communication between farm staff, ensuring that any issues related to animal health or production are promptly addressed.
On the other hand, agricultural businesses will benefit from advanced reporting tools that provide insights into farm performance, helping them make data-driven decisions. This integrated system simplifies farm management tasks, improves data accuracy, and ultimately enhances the productivity and sustainability of the farming operations.

# User Stories
Farm Manager

1. As a farm manager, I want to track the health records of each cow to ensure timely medical care and maintain herd health.
2. As a farm manager, I want to monitor daily milk production per cow to identify trends and optimize milk yields.
3. As a farm manager, I want to receive notifications about irregularities in milk production or cow health so that I can take immediate action.
4. As a farm manager, I want to generate reports on farm performance, including milk production and herd health metrics, to inform decision-making and strategic planning.
5. As a farm manager, I want to communicate directly with farm staff through the system to coordinate tasks and ensure operational efficiency.

Farm Staff

1. As a farm staff member, I want to update cow health records after routine checks so that the data is always accurate and up to date.
2. As a farm staff member, I want to log milk production data daily to keep the farm manager informed about the output.
3. As a farm staff member, I want to receive task assignments from the farm manager through the system so that I know what needs to be done each day.
4. As a farm staff member, I want to report any issues with cows or equipment directly through the system so that problems can be resolved quickly.
5. As a farm staff member, I want to access historical data on cow health and milk production to understand trends better and prepare for future tasks.

# Requirement Prioritization (MoSCoW Technique)
M(Must have):
1. The system must only allow access to authenticated users. Authentication is crucial for ensuring security and proper access control.
2. The farm manager must be able to view detailed health records for each cow. This is essential for managing the health of the livestock effectively.
3. The farm manager must be able to monitor daily milk production data for individual cows. Key functionality for tracking production and ensuring the farm's profitability.
4. The system must allow the farm manager to receive alerts for any irregularities in milk production or cow health. Alerts are critical for timely intervention and problem resolution.
5. Farm staff must be able to update cow health records after routine checks. Ensures that health data is up to date, which is vital for informed decision-making.
6. Farm staff must be able to log daily milk production data into the system. Essential for maintaining accurate production records.
7. The system must allow the farm manager to send notifications to farm staff regarding tasks or issues. Necessary for effective communication and task management.
8. Farm staff must be able to view and acknowledge the notifications sent by the farm manager. Ensures that important information is received and acted upon by the staff.

S(Should have):
1. The farm manager must be able to review and respond to issues reported by farm staff. Improves responsiveness and issue resolution, but basic reporting can be handled manually if needed.
2. The system must provide tools for generating reports on farm performance, including metrics on milk production and cow health. Reporting is valuable for long-term planning and analysis, but it isn’t critical for day-to-day operations.
3. The system must display essential farm information, such as farm ID, bank account details, and contact information. Useful for administrative tasks but not vital for core operations.
4. The farm manager must be able to log and track services performed on the farm, such as equipment maintenance or veterinary visits. Important for maintenance and tracking, but could be done manually if necessary.

C(Could have):
1. The system must provide a real-time chat feature for communication between the farm manager and farm staff. Real-time communication is convenient but can be substituted with other forms of communication if needed.
2. Users must be able to choose between dark mode and light mode within the system. Improves user experience but does not impact the system's core functionality.

W(Won’t have):
1. The system must support both English (US) and English (UK) as language options for the interface. Language support could be useful, but it isn’t critical for the initial release.
2. The system must be accessible to users with visual impairments. Accessibility is important, but depending on the target user base and project scope, it might be deferred to a later version.

# Sprint Planning Overview
Regarding my experience, the complexity of the project and the due dates, I decided to focus on these entities:

ER-Diagram:
<img width="940" height="692" alt="image" src="https://github.com/user-attachments/assets/9edeea99-b260-4851-966c-3d6813f3c1ea" />

Total Time: 4 Weeks (1 month)

Sprint Duration: 1 week per sprint

Number of Sprints: 4 sprints (including a potential stretch sprint)

## Sprint 1: Core Setup and Master Data

Focus:
- Setting up the foundational components of the system.

Tasks:
1. Set up the development environment:
- Configure the database.
- Establish version control.
2. Implement the Cow (Master Table) entity:
- Create the table in the database.
- Implement basic CRUD (Create, Read, Update, Delete) operations.
- Integrate the BreedType (Supplemental) relationship.
3. Implement the BreedType (Supplemental) entity:
- Create the table in the database.
- Implement basic CRUD operations.
4. Testing:
- Test the Cow and BreedType entities to ensure they work as expected.

Deliverables:
- Functional Cow and BreedType tables with proper relationships and CRUD operations.

## Sprint 2: Milk Production Tracking

Focus:
- Implementing the milk production tracking functionality.

Tasks:
1. Implement the MilkProductionHeader (Document) entity:
- Create the table in the database.
- Implement basic CRUD operations.
2. Implement the MilkProductionLine (Document) entity:
- Create the table in the database.
- Implement basic CRUD operations.
- Establish the relationship between MilkProductionLine and Cow.
- Establish the relationship between MilkProductionLine and MilkProductionHeader.
3. Testing:
- Test the milk production tracking system by inserting sample data and verifying outputs.

Deliverables:
- Functional milk production tracking system with MilkProductionHeader and MilkProductionLine entities.

## Sprint 3: UI and Integration

Focus:
- Developing a user interface and integrating the components implemented so far.

Tasks:
1. Develop a basic UI:
- Create a simple interface for managing cows, breeds, and milk production.
2. Integrate front-end and back-end:
- Connect the UI to the database.
- Implement input forms and data displays for Cow, BreedType, MilkProductionHeader, and MilkProductionLine.
3. Testing:
- Perform end-to-end testing of the system.
- Ensure that the UI correctly interacts with the database and that data integrity is maintained.

Deliverables:
- Basic UI integrated with the backend, allowing for management of cows and tracking of milk production.

## Sprint 4: Stretch Goals and Finalization

Focus:
- Final polishing, documentation, and potentially adding the HealthRecord entity.

Tasks:
1. Polish and optimize:
- Refine any rough edges in the system.
- Optimize queries and database performance if necessary.
2. Implement the HealthRecord (Journal) entity (if time permits):
- Create the table in the database.
- Implement CRUD operations.
- Establish the relationship between HealthRecord and Cow.
3. Documentation:
- Document the entire system, including database schema, API endpoints, and usage instructions.
4. Final Testing:
- Conduct comprehensive testing to ensure the system is robust and bug-free.

Deliverables:
- Finalized system with potential inclusion of the HealthRecord entity.
- Comprehensive documentation ready for handover or deployment.







