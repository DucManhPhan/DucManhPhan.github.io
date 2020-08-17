1. Use HealthCareBusinessContext, and SessionContextProvider.

    import nittsusystem.healthcare.shared.common.session.HealthCareBusinessContext;
    import nittsusystem.healthcare.shared.common.session.SessionContextProvider;

    Use two class HealthCareBusinessContext and SessionContextProvider to get ContractCode and CompanyCode of user that have just signed up.
    

2. Use some annotations in javax servlet.

    @Stateless - import javax.ejb.Stateless;
    @Inject    - import javax.inject.Inject;

    ```Service``` class have to write in ```application``` layer.
    
    ```Service```, ```Repository```, ```Finder``` classes is accompany with annotation ```@Stateless```.

3. In ```app``` layer, we have:

    - ```Finder```/```Query``` class in ```query``` folder.
    - ```Command``` (CRD) will be created in ```command``` folder.
    - ```QueryProcessor``` will be in ```processor``` folder.
    - ```service``` folder.
    - DTO object will be created in ```dto``` folder

4. Create ```<<service>>``` implementation in ```service``` folder.

5. Create ```repository``` class in ```repository``` folder.

6. In ```infra``` layer, create ```repositoryImpl``` class in ```query``` folder.

7. Get information about FormError:

    ```js
    if (!nts.ui.formError.isEmpty()) {
        nts.ui.formError.showBoard();
        self.canRegister(true);
        self.canRemove(true);
        dfd.resolve(false);
        return dfd.promise();
    }
    ```

8. Take care about calling ```ajax()``` method in ```request.js``` file that is in ```healthcare.web/src/main/webapp/resources/lib/nittsu``` directory

    ```js
    request.ajax = function (path, data, options) {
        var d = $.Deferred();
        options = options || {};

        if (data === undefined) {
            data = {};
        }

        if (typeof data === 'object') {
            data = JSON.stringify(data);
        }
        console.log(data);
        var locator = setupLocatorWithSubSession(nts.request.location.ajaxRoot, path);

        $.ajax({
            type: options.method || 'POST',
            contentType: options.contentType || 'application/json',
            url: locator.serialize(),
            dataType: options.dataType || 'json',
            data: data,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(nts.names.requestHeader.csrfToken, CsrfTokenRepository.get());
                xhr.setRequestHeader(nts.names.requestHeader.pagePath, request.location.current.rawUrl);

                // Add sub session id
                if (subSessionIdRepository.hasSubSession()) {
                    xhr.setRequestHeader(nts.names.requestHeader.subSessionId, subSessionIdRepository.get());
                }
            }
        }).done(function (res) {
            if (res === undefined || res === null) {
                // empty response
                d.resolve();
            } else if (request.isError(res)){
            	if (res.businessException) {
            		d.reject(res);
            	} else {
            		request.ajaxError(res, d)
            	}
            } else {
                d.resolve(res);
            }
        }).fail(function (res) {
            request.ajaxFailed(res, d)
        });

        return d.promise();
    };
    ```

9. Jump to toppage.

    ```js
    /**
     * Jump to top page.
     */
    request.jumpToTop = function () {
        var pathToTop = nts.sessionStorage.getItem(nts.names.sessionStorage.pathToTop);
        request.jump(pathToTop);
    };
    ```

10. Jump to specific page.

    ```js
    /**
     * Jump to specified page.
     * 
     * @param {String}
     *            path path to destination
     * @returns {undefined}
     */
    request.jump = function (path, data) {
        
        path = new Locator(applicationRootPath).mergeRelativePath(path).appRootRelative();

        var locator = setupLocatorWithSubSession(nts.request.location.appRoot, path);

        var crossPageTemp = {
            from: request.location.current.appRootRelative(),
            path: path,
            data: data
        };

        nts.sessionStorage.setItem(nts.names.sessionStorage.crossPageTemp, JSON.stringify(crossPageTemp));

        nts.ui.jump(locator.serialize());
    };

    request.jumpImmediately = function (path) {
        if (!/^http/.test(path)) {
            path = setupLocatorWithSubSession(nts.request.location.ajaxRoot, path).serialize();
        }

        nts.ui.jump(path, true);
    };
    
    request.newWindow = function (path) {
        if (!/^http/.test(path)) {
            path = new Locator(applicationRootPath).mergeRelativePath(path).serialize();
        }

        return window.open(path);
    }
    ```

11. Utility about showing modal, modeless dialog, some pages.

    ```js
    /**
     * Jump to system error page.
     */
    request.jumpToSystemError = function () {
    	nts.sessionStorage.setItemStringifyJson(nts.names.sessionStorage.systemError, {
    		time: nts.text.formatDate(new Date(), 'yyyy/MM/dd hh:mm:ss'),
    		url: location.href
    	});
    	
    	nts.ui.confirmSaveDisable();
    	request.jump('/error/system/index.xhtml');
    };
    
    /**
     * Jump to previous page.
     */
    request.back = function () {
        request.jump(request.pathToBack);
    };
    
    /**
     * Set previous page to jump.
     */
    request.setBack = function (pathToBack) {
        request.pathToBack = pathToBack;
    };

    /**
     * Download a file from specified path.
     * 
     * @param {String}
     *            path path to download
     * @returns {undefined}
     */
    request.downloadFrom = function (path) {
        request.jumpImmediately(path);
    };

    /**
     * Show modal dialog.
     * 
     * @param {String}
     *            path to the page that will be shown on dialog
     * @param {type}
     *            options
     * @returns handler
     */
    request.modalDialog = function (path, options) {
        var locator = setupLocatorWithSubSession(nts.request.location.appRoot, path);
        return nts.ui.modalDialog(locator.serialize(), options);
    };

    /**
     * Show modeless dialog.
     * 
     * @param {String}
     *            path to the page that will be shown on dialog
     * @param {type}
     *            options
     * @returns handler
     */
    request.modelessDialog = function (path, options) {
        var locator = setupLocatorWithSubSession(nts.request.location.appRoot, path);
        return nts.ui.modelessDialog(locator.serialize(), options);
    };
    ```

12. If service do not return something, and sometimes, it returns error.

    Refer: ```healthcare.web/src/main/webapp/hm/dail/0101/service.js```

    ```javascript
    services.checkSupportManageDailyData = function() {
		var dfd = $.Deferred();

		nts.request.ajax(servicePath.checkSupportManageDailyData).done(function() {
			return dfd.resolve();
		}).fail(function (error) {
            if (error.messageId === 'Hcs_0000083') {
            	nts.ui.alert(nts.ui.message("Hcs_0000083")).then(function() {
					// after dialog closed
					nts.request.jumpToTop();
				});
            }
        });

		return dfd.promise();
	};
    ```

    And in backend, we will throw error:

    ```java
    @POST
    @Path("validate/checkSupportManageDailyData")
	public void checkSupportManageDailyData(){
		ContractFeaturePatternDto contractFeature = contractFinder.find(SessionContextProvider.business().getContractCode());
		if(!contractFeature.getCommonFunctionSetting().isSupportManageDailyData()){
			throw new BusinessException("Hcs_0000083");
		}
	}
    ```

13. Object ```_``` is in external library - lodash.js

14. Note about ```AggregateRoot``` and ```Entity``` that used to map with table in database.

    In order to know about ```AggregateRoot``` and ```Entity```, we can refer to the class:
    - ```MedicineCategory``` class in ```hc.dom/src/main/java/nts/hc/ctx/hc/dom/medicine/MedicineCategory```.

        ```java
        @Getter
        public class MedicineCategory extends AggregateRoot {

            /** The id. */
            private String id;

            /** The name. */
            private String name;

            /** The influence checkup item. */
            private List<String> influenceCheckupItem;

            /**
            * Instantiates a new medicine category.
            *
            * @param id the id
            * @param name the name
            * @param influenceCheckupItem the influence checkup item
            */
            public MedicineCategory(String id, String name, List<String> influenceCheckupItem) {
                super();
                this.id = id;
                this.name = name;
                this.influenceCheckupItem = influenceCheckupItem;
            }
        }
        ```

    - ```HhcctMedCategory``` class in ```hc.infra/src/main/java/nts/hc/ctx/hc/infra/dataaccess/entity/healthcheckup/HhcctMedCategory.java```.

        ```java
        @Entity
        @Table(name = "HHCCT_MED_CATEGORY")
        @Data
        public class HhcctMedCategory implements Serializable {

            /**
            * 
            */
            private static final long serialVersionUID = 1L;

            @Id
            @Column(name = "ID")
            private String id;

            @Column(name = "NAME")
            private String name;

            @OneToMany(cascade = CascadeType.ALL, mappedBy = "hhcctMedCategory")
            private List<HhcctMedCheckupitem> hhcctMedCheckupitems;

        }
        ```

    - ```JpaMedicineCategoryRepository``` class in ```hc.infra/src/main/java/nts/hc/ctx/hc/infra/jpa/dom/medicine/JpaMedicineCategoryRepository.java```.

        ```java
        @Stateless
        public class JpaMedicineCategoryRepository extends HealthCareRepositoryBase implements MedicineCategoryRepository {

            private static final String FIND_BY_IDS = "SELECT h FROM HhcctMedCategory h"
                                                    + " WHERE h.id IN :ids";
            
            @Override
            public Optional<MedicineCategory> find(String id) {
                HhcctMedCategory medCategory = this.getConnection().getEntityFromDatabase(HhcctMedCategory.class, id);
                if(medCategory == null) {
                    return Optional.empty();
                }
                
                return Optional.of(this.toDomain(medCategory));
            }

            @Override
            public List<MedicineCategory> findByIds(List<String> ids) {
                if (ids.isEmpty()) {
                    return new ArrayList<>();
                }
                List<HhcctMedCategory> entities = this.getConnection()
                        .query(FIND_BY_IDS, HhcctMedCategory.class)
                        .setParameter("ids", ids)
                        .getList();
                return entities.stream()
                        .map(this::toDomain)
                        .collect(Collectors.toList());
            }
            
            private MedicineCategory toDomain(HhcctMedCategory medCategory) {
                List<String> influenceCheckupItem = medCategory.getHhcctMedCheckupitems().stream()
                        .map(x -> x.getHhcctMedCheckupitemPK().getCheckupItem())
                        .collect(Collectors.toList());
                return new MedicineCategory(medCategory.getId(), medCategory.getName(), influenceCheckupItem);
            }
        }
        ```
    
    - After doing these, in ```app``` layer, we should create DTO object in ```dto``` package.

        It means that in Finder class of ```app``` layer, we will call some methods from ```Repository``` class to get information.

        This information is a type of ```AggregateRoot``` class. So, we have to transfer this type into DTO object in ```app``` layer.

    --> So, we have shortcut about transfering data between layers:
        
        infra      -->         dom           -->      app

        Entity     -->     AggregateRoot     -->      Dto object    

15. Context A will call context B through package ```pub``` and ```pubImpl```.

16. In order to use a table of ```op``` context in ```hc``` context:

    There are some steps that we need to implement:
    - In ```op``` context, create table that will be abided by the rule of database's name.

    - To share data between ```op``` context and ```hc``` context:
        - Use ```pub``` and ```pubImpl``` layer in ```op``` context.
        - Use ```ac``` layer in ```hc``` context to call the method from ```pub``` layer in ```op``` context.

    - In ```pub``` layer of ```op``` context
    
        Create interface to encapsulate all methods that will be utilized in other layers of other context.

        Create dto object that have properties are corresponded to the table.
    
    - In ```pubImpl``` layer of ```op``` context

        Create implementation class of the above interface in ```pub``` layer of ```op``` context. 

        We will use ```Repository``` class in ```dom``` layer of ```op``` context. Then, use ```@Inject``` annotation to call somewhat method to pass object of ```Repository```'s implementation into it. And, also we use ```AggregateRoot``` class in ```dom``` layer of ```op``` context.

        In methods of implementation class of the above interface that is in ```pub``` layer of ```op``` context, convert object of ```AggregateRoot``` class to dto object in ```pub``` layer of ```op``` context.
    
    - In ```app``` layer of ```hc``` context, we will define operations that we want to use in interface.

    - In ```ac``` layer of ```hc``` context, we will implement the above interface of ```hc.app``` and contains the property that is of type of interface in ```op.pub```.

    - 

    
    For example:

    1. In ```pub``` layer of ```cm``` context, create dto object and interface that will be used to communicate with other context.
        - Create interface ```HealthCheckOrderRepository```

            ```java
            package nts.hc.ctx.cm.pub.healthcheckorder;

            import nts.hc.ctx.cm.pub.healthcheckorder.dto.HealthCheckOrderDto;
            import nts.hc.ctx.cm.pub.healthcheckorder.dto.HealthCheckOrderPubDto;
            import nts.hc.ctx.cm.pub.healthcheckorder.dto.HealthCheckupPeriod;

            public interface HealthCheckOrderRepository {
                
                public HealthCheckOrderDto getInstructionPeriod(String employeeCode, String contractCode, int companyCode, String carePlanCode);
                            
                public List<HealthCheckOrderPubDto> getInstructionPeriod(List<String> userIdList, String contractCode, int companyCode, String carePlanCode);
                        
                public Map<String, List<HealthCheckOrderDto>> getHealthCheckOrders(String contractCode, int companyCode, List<String> careplanCodes);
                
                
                public List<HealthCheckOrderDto> getHealthCheckOrderByUserId(String userId, String contractCode, int companyCode, boolean isEmployee);
                        
                public boolean isUsedInstitution(String contractCode, int companyCode, String institutionCode);
                            
                public List<HealthCheckupPeriod> getHealthCheckPeriod(String careplanCode, List<String> userIds);
            }
            ```

        - Create ```HealthCheckOrderDto```

            ```java
            package nts.hc.ctx.cm.pub.healthcheckorder.dto;

            import lombok.Data;
            import nittsusystem.healthcare.shared.common.time.GeneralDate;

            @Data
            public class HealthCheckOrderDto {
                
                private  String contractCode;
                
                private  int companyCode;
                            
                private  String carePlanCode;
                            
                private  String employeeCode;
                            
                private String userId;
                
                private Date deadlineDate;
                
                private Date startDate;
                
                private String healthCheckupInstitutionCode;
                            
                private int healthCheckStatus;
                            
                private GeneralDate completedDate;

                public HealthCheckOrderDto() {
                    super();
                }

                public HealthCheckOrderDto(String contractCode, int companyCode, String carePlanCode, String employeeCode,
                        Date deadlineDate, Date startDate, String healthCheckupInstitutionCode) {
                    super();
                    this.contractCode = contractCode;
                    this.companyCode = companyCode;
                    this.carePlanCode = carePlanCode;
                    this.employeeCode = employeeCode;
                    this.deadlineDate = deadlineDate;
                    this.startDate = startDate;
                    this.healthCheckupInstitutionCode = healthCheckupInstitutionCode;
                }
                

                public HealthCheckOrderDto(String contractCode, int companyCode, String carePlanCode, String employeeCode,
                        Date deadlineDate, Date startDate, String healthCheckupInstitutionCode, String userId) {
                    super();
                    this.contractCode = contractCode;
                    this.employeeCode = employeeCode;
                    this.companyCode = companyCode;
                    this.carePlanCode = carePlanCode;
                    this.userId = userId;
                    this.deadlineDate = deadlineDate;
                    this.startDate = startDate;
                    this.healthCheckupInstitutionCode = healthCheckupInstitutionCode;
                }
            }
            ```

    2. ```pubImpl``` layer of ```cm``` context, create implementation of interface ```HealthCheckOrderRepository```.

        ```java    
        package nts.hc.ctx.cm.pubimp.healthcheckorder;

        @Stateless
        public class HealthCheckOrderImpl implements HealthCheckOrderRepository {

            // HealthCheckupOrderRepository interface isin dom layer of cm context.
            @Inject
            private HealthCheckupOrderRepository healthCheckRepo;

            @Inject
            private UserIdAdapter userIdRepo;

            @Inject
            private SpecialUserAdapter specialAdapter;
            
            @Inject
            private HealthCheckupStatusRepository healthCheckupStatusRepository;

            @Override
            public HealthCheckOrderDto getInstructionPeriod(String employeeCode, String contractCode, int companyCode,
                    String carePlanCode) {
                SubjectContext context = new SubjectContext(contractCode, companyCode, carePlanCode, employeeCode);
                // Get order
                HealthCheckupOrder order = this.healthCheckRepo.getOrder(context);

                // Get userId.    
                HealthCheckOrderDto result = new HealthCheckOrderDto(
                        order.getSubjectContext().getContext().getContractCode(),
                        order.getSubjectContext().getContext().getCompanyCode(),
                        order.getSubjectContext().getCarePlanCode().original(),
                        employeeCode,
                        order.getDeadlineDate(), order.getStartDate(),
                        order.getHealthCheckupInstitutionCode(), 
                        order.getSubjectContext().getUserId());//userId);

                // Get status
                Optional<SubjectHealthCheckupStatus> healthStatus = this.healthCheckupStatusRepository
                        .getSubjectHealthCheckupStatus(context);

                if (healthStatus.isPresent()) {
                    result.setHealthCheckStatus(healthStatus.get().getHealthCheckupStatus().value);
                    result.setCompletedDate(healthStatus.get().getCompletedDate() == null ? null : 
                        new GeneralDate(healthStatus.get().getCompletedDate()));
                }

                return result;
            }

            @Override
            public Map<String, List<HealthCheckOrderDto>> getHealthCheckOrders(String contractCode, int companyCode,
                    List<String> careplanCodes) {
                ...
            }

            @Override
            public List<HealthCheckOrderDto> getHealthCheckOrderByUserId(String userId, String contractCode, int companyCode,
                    boolean isEmployee) {
                ...
            }

            @Override
            public boolean isUsedInstitution(String contractCode, int companyCode, String institutionCode) {
                return !this.healthCheckRepo.findUserByHealthCheckupInstitution(contractCode, companyCode, institutionCode).isEmpty();
            }

            @Override
            public List<HealthCheckOrderPubDto> getInstructionPeriod(List<String> userIdList, String contractCode,
                    int companyCode, String carePlanCode) {
                ...            
            }

            @Override
            public List<HealthCheckupPeriod> getHealthCheckPeriod(String careplanCode, List<String> userIds) {
                ...
            }
        }
        ```

    3. In ```hc.app```, to define ```HealthCheckOrderAdaptor``` interface that contains all target operations that we want in ```op.pub``` layer and define dto for objects such as ```HealthCheckDto```, ```HealthCheckupPeriod```.

        ```java
        package nts.hc.ctx.hc.app.adaptor.cm;

        import nittsusystem.healthcare.shared.common.time.GeneralDate;
        import nts.hc.ctx.hc.app.adaptor.cm.dto.HealthCheckDto;
        import nts.hc.ctx.hc.app.adaptor.cm.dto.HealthCheckupPeriod;

        public interface HealthCheckOrderAdaptor {

            List<HealthCheckDto> getHealthCheckByInstitution(String contractCode, int companyCode,
                    List<String> careplanCodes, GeneralDate startDate, GeneralDate endDate, String institutionCode);

            List<HealthCheckDto> getHealthCheckByStatus(String contractCode, int companyCode,
                    List<String> careplanCodes);

            List<HealthCheckDto> getHealthCheckByCarePlan(String contractCode, int companyCode,
                    List<String> careplanCodes, String institutionCode);
            
            HealthCheckDto getInstructionPeriod(String employeeCode, String contractCode, int companyCode,
                    String carePlanCode);
                        
            List<HealthCheckupPeriod> getHealthCheckupPeriods(String careplanCode, List<String> userIds);
        }
        ```

    4. Define implementation of ```HealthCheckOrderAdaptor``` in ```hc.ac```.

        ```java
        package nts.hc.ctx.hc.ac.cm;

        import nts.hc.ctx.cm.pub.healthcheckorder.HealthCheckOrderRepository;
        import nts.hc.ctx.cm.pub.healthcheckorder.dto.HealthCheckOrderDto;
        import nts.hc.ctx.hc.app.adaptor.cm.HealthCheckOrderAdaptor;
        import nts.hc.ctx.hc.app.adaptor.cm.dto.HealthCheckDto;
        import nts.hc.ctx.hc.app.adaptor.cm.dto.HealthCheckupPeriod;

        @Stateless
        public class HealthCheckOrderAdaptorImpl implements HealthCheckOrderAdaptor {

            @Inject
            private HealthCheckOrderRepository checkupOrderRepository;

            @Override
            public List<HealthCheckDto> getHealthCheckByInstitution(String contractCode, int companyCode,
                    List<String> careplanCodes, GeneralDate startDate, GeneralDate endDate, String institutionCode) {
                ...
            }

            @Override
            public List<HealthCheckDto> getHealthCheckByStatus(String contractCode, int companyCode,
                    List<String> careplanCodes) {
                ...
            }

            @Override
            public List<HealthCheckDto> getHealthCheckByCarePlan(String contractCode, int companyCode,
                    List<String> careplanCodes, String institutionCode) {
                ...
            }

        //    SinhND
            @Override
            public HealthCheckDto getInstructionPeriod(String employeeCode, String contractCode, int companyCode, String carePlanCode) {
                HealthCheckOrderDto dto = checkupOrderRepository.getInstructionPeriod(employeeCode, contractCode, companyCode, carePlanCode);
                HealthCheckDto result = new HealthCheckDto();
                result.setCarePlanCode(dto.getCarePlanCode());
                result.setCompanyCode(dto.getCompanyCode());
                result.setContractCode(dto.getContractCode());
                result.setDeadlineDate(dto.getDeadlineDate());
                result.setUserId(dto.getUserId());
                result.setHealthCheckStatus(dto.getHealthCheckStatus());
                result.setHealthCheckupInstitutionCode(dto.getHealthCheckupInstitutionCode());
                result.setStartDate(dto.getStartDate());
                return result;
            }

            @Override
            public List<HealthCheckupPeriod> getHealthCheckupPeriods(String careplanCode, List<String> userIds) {
                List<nts.hc.ctx.cm.pub.healthcheckorder.dto.HealthCheckupPeriod> checkupPeriods 
                        = checkupOrderRepository.getHealthCheckPeriod(careplanCode, userIds);
                
                return checkupPeriods.stream().map(x ->{
                    return new HealthCheckupPeriod(x.getDeadlineDate(), x.getStartDate(), x.getUserId());
                }).collect(Collectors.toList());
            }
        }
        ```

    5. After doing this, in ```hc.app```, ```HealthCheckOrderAdaptorImpl``` class will be inject to other class with ```HealthCheckOrderAdaptor``` class.

        ```java
        @Stateless
        public class ExaminationSituationQueryProcessor
                implements QueryProcessor<ExaminationSituationQuery, ExaminationSituationQueryResult> {

            @Inject
            private ICompanySettingShareFind companySettingShareFind;

            @Inject
            private HealthCheckOrderAdaptor healthCheckOrderAdaptor;

            @Inject
            private ICompanyInfor iCompanyInfor;

            @Inject
            private IHealthCheckupEvaluationQueryRepo evaluationQueryRepo;

            @Override
            public ExaminationSituationQueryResult handle(ExaminationSituationQuery query) {
                String contractCode = SessionContextProvider.business().getContractCode();
                int companyCode = SessionContextProvider.business().getCompanyCode();
                CompanySettingBaseDto companySettingBase = companySettingShareFind
                        .getCompanySetting(contractCode, companyCode);
                if (query.getEndDate() == null) {
                    query.setEndDate(GeneralDate.max().rawDate());
                }
                return getExaminationResult(companySettingBase.getExporting(), contractCode, companyCode, query);
            }

            private ExaminationSituationQueryResult getExaminationResult(int exporting,
            String contractCode, int companyCode, ExaminationSituationQuery query) {
                ...
                //get instruction list
                List<HealthCheckDto> healthCheckList = healthCheckOrderAdaptor.getHealthCheckByCarePlan(
                        contractCode, companyCode, query.getCarePlanCodes(), query.getInstitutionCode());
                if (healthCheckList.isEmpty() || employeeSearchResultModel.getEmployeeDetail() == null) {
                    throw new BusinessException("Com_0000081");
                }

                ...
            }
        }
        ```

17. When we have status about our screen. We need to take care about it. 

    ![](../img/State-transition-diagram.png)

    - All these states will be implemented in back-end. If the state diagram has ```<<service>>```, it will be created in ```app``` layer with suffix ```Service```. Otherwise, it will have the ```Finder``` suffix.

    - We have to completely finish all works in back-end before jumping into front-end to code UI.

    - For example

        1. In ```em.app``` layer, we create a class with suffix ```Service```.

            ```java
            package nts.hc.ctx.em.app.closure.service;

            import nts.hc.ctx.em.dom.repository.closure.ClosureDateRepository;

            @Stateless
            public class ClosureDateService {

                @Inject
                private ClosureDateRepository repo;

                public void addClosureDate(String contractCode, int companyCode) {
                    ClosureDate domain = new ClosureDate(Deadline.MONTH_END, new HealthCareBusinessContext(contractCode, companyCode));
                    repo.addClosureDate(domain);
                }
            }
            ```

        2. In ```em.dom``` layer, create interface for Repository.

            ```java
            public interface ClosureDateRepository {
                
                ClosureDate getClosureDate(String contractCode, int companyCode);

                void addClosureDate(ClosureDate closureDate);
            }
            ```

        3. In ```em.infra``` layer, create implementation of ```ClosureDateRepository``` interface.

            ```java
            import nts.hc.ctx.em.dom.repository.closure.ClosureDateRepository;
            import nts.hc.ctx.em.infra.entity.closure.HemmtClosureDate;
            import nts.hc.shr.infra.data.DataConnection;
            import nts.hc.shr.infra.data.repository.HealthCareRepositoryBase;s
            
            public class ClosureDateRepositoryImpl extends HealthCareRepositoryBase implements ClosureDateRepository{
                
                @Inject 
                private DataConnection connect;

                public ClosureDate getClosureDate(String contractCode, int companyCode) {
                    return new ClosureDate(EnumAdaptor.valueOf(closureDate.getClosureDate(), Deadline.class), new HealthCareBusinessContext(contractCode, companyCode));
                }

                public void addClosureDate(ClosureDate closureDate) {
                    	HemmtClosureDate entity = new HemmtClosureDate();
                        entity.setContractCode(closureDate.getContractCompany().getContractCode());
                        entity.setCompanyCode(closureDate.getContractCompany().getCompanyCode());
                        entity.setClosureDate(closureDate.getClosureDate().value);
                        this.getConnection().insertEntity(entity);
                }
            }
            ```

            Create ```HeemmtClosureDate``` entity class in ```em.infra.entity.closure```.

            ```java
            package nts.hc.ctx.em.infra.entity.closure;

            @Data
            @Entity
            @Table(name = "HEMMT_CLOSURE_DATE")
            public class HemmtClosureDate implements Serializable{

                @Id
                @Column(name = "CONTRACT_CODE")
                private String contractCode;

                @Id
                @Column(name = "COMPANY_CODE")
                private int companyCode;

                @Column(name = "CLOSURE_DATE")
                private int closureDate;

                public HemmtClosureDate() {
                }

                public HemmtClosureDate(String contractCode, int companyCode, int closureDate) {
                    this.contractCode = contractCode;
                    this.companyCode = companyCode;
                    this.closureDate = closureDate;
                }
            }
            ```

        4. In ```em.ws``` layer, create ```ClosureDateWebservice``` class.

            ```java
            package nts.hc.ctx.em.ws.domain.closure;

            import nts.hc.ctx.em.app.closure.service.ClosureDateService;
            import nts.hc.ctx.em.ws.domain.closure.dto.AddClosureDateDto;
            import nts.hc.shr.infra.web.WebServiceBase;

            @Path("/domain/em/closure")
            @Produces("application/json")
            public class ClosureDateWebservice extends WebServiceBase {

                @Inject
                private ClosureDateService closureDateService;

                @POST
                @Path("add")
                public void addClosureDate(AddClosureDateDto dto) {
                    closureDateService.addClosureDate(dto.getContractCode(), dto.getCompanyCode());
                }
            }
            ```

            Create ```AddClosureDateDto``` class in ```em.ws.domain.closure.dto``` package.

            ```java
            package nts.hc.ctx.em.ws.domain.closure.dto;

            import lombok.Data;

            @Data
            public class AddClosureDateDto {

                private String contractCode;

                private int companyCode;

                public AddClosureDateDto() {
                }
            }
            ```

18. When our design that has ```AggregateRoot``` class, we will have to create ```AggregateRoot``` class in ```dom``` layer.

    For example:

    0. Create ```ManualEntryDataUseService``` class.

        ```java
        package nts.hc.ctx.hc.app.dailydata.permission;

        import nittsusystem.healthcare.shared.common.session.HealthCareBusinessContext;
        import nts.hc.ctx.hc.dom.domain.dailydata.permission.ManualEntryDataUse;
        import nts.hc.ctx.hc.dom.domain.dailydata.permission.ManualEntryDataUseRepository;
        import nts.hc.ctx.hc.dom.domain.dailydata.permission.PermissionState;

        @Stateless
        public class ManualEntryDataUseService {

            @Inject
            private ManualEntryDataUseRepository repo;

            public void addManualEntryDataUse(String contractCode, int companyCode) {
                List<PermissionState> permissionStates = new ArrayList<>();
                PermissionState permissionState = new PermissionState("2", false);
                permissionStates.add(permissionState);
                ManualEntryDataUse dom = new ManualEntryDataUse(new HealthCareBusinessContext(contractCode, companyCode), permissionStates);
                repo.insert(dom);
            }
        }
        ```

    1. Create ```AggregateRoot``` class in ```hc.dom``` layer.

        ```java
        package nts.hc.ctx.hc.dom.domain.dailydata.permission;

        import java.util.List;

        import nittsusystem.healthcare.shared.common.domain.entity.AggregateRoot;
        import nittsusystem.healthcare.shared.common.session.HealthCareBusinessContext;

        @Getter
        public class ManualEntryDataUse extends AggregateRoot {

            private HealthCareBusinessContext contractCompany;

            private List<PermissionState> permissionState;

            public ManualEntryDataUse(HealthCareBusinessContext contractCompany, List<PermissionState> permissionState) {
                this.contractCompany = contractCompany;
                this.permissionState = permissionState;
            }
        }
        ```

        --> We have to remain the properties in ```AggregateRoot``` class such as ```ManualEntryDataUse``` that includes: ```HealthCareBusinessContext``` and ```List<PermissionState>```.

    2. In ```hc.dom``` layer, create interface of Repository.

        ```java
        package nts.hc.ctx.hc.dom.domain.dailydata.permission;

        public interface ManualEntryDataUseRepository {

            void insert(ManualEntryDataUse manualEntryDataUse);
        }
        ```

    3. In ```hc.infra``` layer, create implementation of ```ManualEntryDataUseRepository``` interface.

        ```java
        package nts.hc.ctx.hc.infra.dataaccess.command.dailydata.permission;

        import nts.hc.ctx.hc.dom.domain.dailydata.permission.ManualEntryDataUse;
        import nts.hc.ctx.hc.dom.domain.dailydata.permission.ManualEntryDataUseRepository;
        import nts.hc.ctx.hc.infra.dataaccess.entity.dailydata.permission.HhcmManuallyEntry;
        import nts.hc.shr.infra.data.repository.HealthCareRepositoryBase;

        @Stateless
        public class ManualEntryDataUseRepositoryImpl extends HealthCareRepositoryBase implements ManualEntryDataUseRepository {
            
            // ManualEntryDataUse is AggregateRoot class
            @Override
            public void insert(ManualEntryDataUse manualEntryDataUse) {
                List<HhcmManuallyEntry> entities = this.toEntity(manualEntryDataUse);
                entities.forEach(entity -> this.getConnection().insertEntity(entity));
            }

            private List<HhcmManuallyEntry> toEntity(ManualEntryDataUse domain) {
                List<HhcmManuallyEntry> result = new ArrayList<>();
                domain.getPermissionState().forEach(permissionState -> {
                    HhcmManuallyEntry entity = new HhcmManuallyEntry();
                    entity.setCompanyCode(domain.getContractCompany().getCompanyCode());
                    entity.setContractCode(domain.getContractCompany().getContractCode());
                    entity.setVersion(domain.getVersion());
                    entity.setCategoryId(Integer.parseInt(permissionState.getCategoryId()));
                    entity.setAllowed(permissionState.isAllowed());
                    result.add(entity);
                });
                return result;
            }
        }
        ```

        Create entity for the table in ```hc.infra``` layer.

        ```java
        package nts.hc.ctx.hc.infra.dataaccess.entity.dailydata.permission;

        import nts.hc.shr.infra.data.entity.AggregateTableEntity;

        @Data
        @Entity
        @Table(name = "HHCMT_MANUALLY_ENTRY")
        public class HhcmManuallyEntry extends AggregateTableEntity implements Serializable {

            private static final long serialVersionUID = 1L;

            @Id
            @Column(name = "CONTRACT_CODE")
            private String contractCode;

            @Id
            @Column(name = "COMPANY_CODE")
            private int companyCode;

            @Id
            @Column(name = "CATEGORY_ID")
            private int categoryId;

            @Column(name = "IS_ALLOWED")
            private boolean isAllowed;

            public HhcmManuallyEntry() {
            }

            public HhcmManuallyEntry(String contractCode, int companyCode, int categoryId, boolean isAllowed) {
                this.contractCode = contractCode;
                this.companyCode = companyCode;
                this.categoryId = categoryId;
                this.isAllowed = isAllowed;
            }
        }
        ```
    4. In ```hc.ws``` layer, create Dto object.

        ```java
        package nts.hc.ctx.hc.ws.domain.dailydata.permission.dto;

        import lombok.Data;

        @Data
        public class AddManualEntryDataUseDto {

            private String contractCode;

            private int companyCode;

            public AddManualEntryDataUseDto() {
            }
        }
        ```

    5. In ```hc.ws``` layer, create ```PermissionWebService``` class.

        ```java
        package nts.hc.ctx.hc.ws.domain.dailydata.permission.service;

        import nts.hc.ctx.hc.app.dailydata.permission.ManualEntryDataUseService;
        import nts.hc.ctx.hc.ws.domain.dailydata.permission.dto.AddManualEntryDataUseDto;
        import nts.hc.shr.infra.web.WebServiceBase;

        @Path("/domain/hc/permission")
        @Produces("application/json")
        public class PermissionWebService extends WebServiceBase {

            @Inject
            private ManualEntryDataUseService manualEntryDataService;

            @POST
            @Path("add/manualentrydatause")
            public void addManualEntryDataUse(AddManualEntryDataUseDto dto) {
                manualEntryDataService.addManualEntryDataUse(dto.getContractCode(), dto.getCompanyCode());
            }
        }
        ```

    6. In ```service.js``` file, we have:

        ```js
        var services = (function () {

            var servicePath = {
                ...
                addManualEntryDataUse: '/domain/hc/permission/add/manualentrydatause',
                addUseHealthPointManage: '/domain/op/healthpointmanage/add',
                addClosureDate: '/domain/em/closure/add'
            };

            var services = {};

            services.addManualEntryDataUse = function (contractCode, companyCode) {
                var dfd = $.Deferred();
                var object = {
                    contractCode: contractCode,
                    companyCode: companyCode
                };
                nts.request.ajax(servicePath.addManualEntryDataUse, object).done(function (res) {
                    dfd.resolve(res);
                });
                return dfd.promise();
            }

            ...
        }
        ```

    --> Dto object will be created in ```ws``` layer of context. It will be used to convert all argument from ajax() method to Dto object in ```ws``` layer. 

    In object that pass in ajax() method, there are the number of properties, then Dto object will have the same of number properties.

19. Understanding about @OneToMany and @ManyToOne annotations

    ```java
    package nts.hc.ctx.hc.infra.dataaccess.entity.healthcheckupdata.dataimport.companyexam;

    @Getter
    @Setter
    @Entity
    @Table(name = "HHCDT_DATA_RESULT")
    @XmlRootElement
    @Cacheable
    @OptimisticLocking(cascade = true)
    public class HhcdtDataResult implements Serializable {

        @Id
        @Basic(optional = false)
        @Column(name = "CODE")
        private String code;

        @Column(name = "CONTRACT_CODE")
        private String contractCode;
        
        @Column(name = "COMPANY_CODE")
        private int companyCode;
        
        @Column(name = "CARE_PLAN_CODE")
        private String carePlanCode;

        ...

        // @BatchFetch(value=BatchFetchType.EXISTS)
        @OneToMany(cascade = CascadeType.ALL, mappedBy = "checkupDataImportCode", orphanRemoval = true, fetch=FetchType.LAZY)
        private List<HhcdtDataImportItemResult> hhcdtDataImportItemResultCollection;

    }
    ```

    ```java
    package nts.hc.ctx.hc.infra.dataaccess.entity.healthcheckupdata.dataimport.companyexam;

    @Entity
    @Getter
    @Setter
    @Table(name = "HHCDT_DATA_IMPORT_ITEM_RESULT")
    @XmlRootElement

    public class HhcdtDataImportItemResult implements Serializable {

        @Id
        @Basic(optional = false)
        @Column(name = "CODE")
        private String code;
        
        @Column(name = "CHECKUP_ITEM_CODE")
        private String checkupItemCode;
        
        @Column(name = "VALUE")
        private String value;

        @Column(name="CHECKUP_DATA_IMPORT_CODE")
        private String checkupDataCode;

        ...

        @JoinColumn(name = "CHECKUP_DATA_IMPORT_CODE", referencedColumnName = "CODE", updatable = false, insertable = false)
        @ManyToOne
        private HhcdtDataResult checkupDataImportCode;

    }   
    ```

20. In ```Entity``` class of ```infra``` layer, we should use the AggregateTableEntity abstract class that is derived from entities.

    ```java
    package nts.hc.shr.infra.data.entity;

    import javax.persistence.Inheritance;
    import javax.persistence.InheritanceType;
    import javax.persistence.MappedSuperclass;
    import javax.persistence.Version;
    
    @MappedSuperclass
    @Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
    public abstract class AggregateTableEntity {
                
        @Version
        protected long version;
                
        public final long getVersion() {
            return this.version;
        }
                
        public final void setVersion(long version) {
            this.version = version;
        }
    }
    ```

21. When using annotations of lombok package such as ```@Data``` is equivalent to ```@Getter```, ```@Setter```, ```@RequiredArgsConstructor```, ```@ToString```, ```@EqualsAndHashCode```; ```@Getter```; ```@Setter```, ..., sometimes, we need to use the get method of specific property, but it does not appear in our entity class. 

    So, there is a solution for this problem.

    ```java
    @Entity
    @Table(name = "HHCMT_CHECKUP_ITEM_VER")
    @Data
    public class HhcmtCheckupItemVer implements Serializable {

        @Id
        @Column(name = "CHECKUP_ITEM_CODE")
        private String checkupItemCode;

        ...
    }
    ```
    
    Call the getter method of property ```checkupItemCode```: ```HhcmtCheckupItemVer::getCheckupItemCode```.

22. Create our own annotations in java.

    ```java
    @Target({ElementType.CONSTRUCTOR})
    @Retention(RetentionPolicy.RUNTIME)
    @Constraint(validatedBy = IntegerRangeValueValidator.class)
    @Documented
    public @interface IntegerRangeValue {
        
        String message() default "";
        
        Class<?>[] groups() default {};
        
        Class<? extends Payload>[] payload() default {};
        
        int min();
        
        int max();
    }
    ```

    Validate our value that is passed to ```IntegerRangeValue``` class.

    ```java
    @SupportedValidationTarget(ValidationTarget.PARAMETERS)
    public class IntegerRangeValueValidator
        implements ConstraintValidator<IntegerRangeValue, Object[]> {

        private int min;
        
        private int max;

        @Override
        public void initialize(IntegerRangeValue integerRangeValue) {
            this.min = integerRangeValue.min();
            this.max = integerRangeValue.max();
        }

        @Override
        public boolean isValid(Object[] targets, ConstraintValidatorContext constraintValidatorContext) {
            if (!(targets[0] instanceof Integer)) {
                throw new IllegalArgumentException(ValidationMessage.INVALID_ARG);
            }

            if (this.min > this.max) {
                throw new IllegalArgumentException(ValidationMessage.INVALID_RANGE);
            }

            int validatedInt = (Integer) targets[0];
            if (validatedInt < this.min
                    || validatedInt > this.max) {
                return false;
            }
            return true;
        }
    }
    ```

23. When our primary key contains many properties, we can group all properties into one class. And declare this class in class parent with annotation ```@EmbeddedId```.

    For example:

    ```java
    @Entity
    @Table(name = "HCMMT_EXTR_CONDITION")
    @Data
    @NamedQueries({
        @NamedQuery(name = "HcmmtExtrCondition.findAll",
                query = "SELECT h FROM HcmmtExtrCondition h"),
        @NamedQuery(name = "HcmmtExtrCondition.findByContractCode",
                query = "SELECT h FROM HcmmtExtrCondition h WHERE h.id.contractCode = :contractCode"),
        @NamedQuery(name = "HcmmtExtrCondition.findByCompanyCode",
                query = "SELECT h FROM HcmmtExtrCondition h WHERE h.id.companyCode = :companyCode"),
        @NamedQuery(name = "HcmmtExtrCondition.findByConditionCode",
                query = "SELECT h FROM HcmmtExtrCondition h WHERE h.id.conditionCode = :conditionCode")})
    public class HcmmtExtrCondition extends AggregateTableEntity implements Serializable {
       
        private static final long serialVersionUID = 1L;
        
        @EmbeddedId
        private HcmmtExtrConditionPK id;
        
        @Column(name = "AUTO_EXTRACTION_DIVISION", nullable = false)
        private int autoExtractionDivision;
        
        @Column(name = "CONDITION_NAME", nullable = false)
        private String conditionName;

        @Column(name = "CONDITION_TYPE", nullable = false)        
        private int conditionType;
    
        @Column(name = "EXTRACTION_PERIOD", nullable = false)
        private int extractionPeriod;
       
        @OneToMany(mappedBy = "hcmmtExtrCondition", cascade = {CascadeType.ALL})
        private List<HcmmtEventCondition> hcmmtEventConditions;
       
        @OneToMany(mappedBy = "hcmmtExtrCondition", cascade = {CascadeType.ALL})
        private List<HcmmtHlthCkCondition> hcmmtHlthCkConditions;
       
        @OneToMany(mappedBy = "hcmmtExtrCondition", cascade = {CascadeType.ALL})
        private List<HcmmtStrCkCondition> hcmmtStrCkConditions;
                
        @OneToMany(mappedBy = "hcmmtExtrCondition", cascade = {CascadeType.ALL})
        private List<HcmmtTimeNumCondition> hcmmtTimeNumConditions;
        
        @OneToMany(mappedBy = "hcmmtExtrCondition", cascade = {CascadeType.ALL})
        private List<HcmmtExtrPatternDetail> hcmmtExtrPatternDetailList;
        
        public HcmmtExtrCondition() {
            // nothing to do
        }

        ...
    }
    ```

    The class with annotation ```@EmbeddedId```: 

    ```java
    @Embeddable
    @Data
    public class HcmmtExtrConditionPK implements Serializable {
       
        private static final long serialVersionUID = 1L;
        
        @Column(name = "CONTRACT_CODE", length = 12)
        @NotNull
        private String contractCode;
        
        @Column(name = "COMPANY_CODE")
        @NotNull
        private int companyCode;
        
        @Column(name = "CONDITION_CODE", length = 3)
        @NotNull
        private String conditionCode;
        
        public HcmmtExtrConditionPK() {
            // nothing to do
        }
        
        public HcmmtExtrConditionPK(String contractCode, int companyCode, String conditionCode) {
            this.contractCode = contractCode;
            this.companyCode = companyCode;
            this.conditionCode = conditionCode;
        }
                        
        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof HcmmtExtrConditionPK)) {
                return false;
            }
            HcmmtExtrConditionPK castOther = (HcmmtExtrConditionPK) other;
            return this.contractCode.equals(castOther.contractCode)
                    && (this.companyCode == castOther.companyCode)
                    && this.conditionCode.equals(castOther.conditionCode);
        }
        
        public int hashCode() {
            final int prime = 31;
            int hash = 17;
            hash = hash * prime + this.contractCode.hashCode();
            hash = hash * prime + this.companyCode;
            hash = hash * prime + this.conditionCode.hashCode();

            return hash;
        }
    }
    ```


24. In domain class, we have to inheritance from ```AggregateRoot``` class. If in our domain class it has ```version```, we have to extend ```AggregateTableEntity``` class.

    ```java
    @MappedSuperclass
    @Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
    public abstract class AggregateTableEntity {
                
        @Version
        protected long version;
                
        public final long getVersion() {
            return this.version;
        }
                
        public final void setVersion(long version) {
            this.version = version;
        }
    }
    ```

25. How to create DateRange

    ```java
    public void changeEndDate(DutyAndPosition dutyAndPosition) {
        GeneralDate startDate = this.dateRange.getStart();
        GeneralDate endDate = dutyAndPosition.getDateRange().getStart().addDays(-1);
        this.dateRange = DateRange.builder().start(startDate).end(endDate).buildIfReversed("Update End Date");
    }
    ```

26. How to use ```Optional```

    ```java
    public Optional<DutyAndPosition> find(UserId userId, UserId uniqueId) {
        HhrmtDutyAndPositionPK hhrmtDutyAndPositionPK = new HhrmtDutyAndPositionPK(
            uniqueId.original(), userId.original());
        HhrmtDutyAndPosition dutyAndPosition = this.getConnection().getEntityFromDatabase(
            HhrmtDutyAndPosition.class, hhrmtDutyAndPositionPK);
        return Optional.ofNullable(dutyAndPosition == null
            ? null : dutyAndPosition.createDutyAndPosition());
    }
    ```

27. Raise event and receive event in Healthcare.
- Raise event

    ```java
    @Stateless
    public class SheetAnswerGrobalEventServiceImpl implements SheetAnswerGrobalEventService {

        @Override
        public void createAddPerMedicalHistoryEvent(String userId, String illnessId, GeneralDate answerDate) {
            
            GlobalEvent globalEvent = new GlobalEvent("HC_AddPersonalMedicalHistory");
            globalEvent.setData("userId", userId);
            globalEvent.setData("illnessId", illnessId);
            globalEvent.setDate("answerDate", answerDate);
            
            GlobalEventPublisher.publish(globalEvent);
            
        }

        ...

    }
    ```

- Receive event

    In ```nts.hc.ctx.hr.dom.globalevent.subscriber``` package:

    ```java
    @Stateless
    @GlobalEventHandler("HC_AddPersonalMedicalHistory")
    public class RegisterHealthCheckupSheet implements GlobalEventSubscriber {

        @Inject
        private PersonalMedicalHistoryService personalMedicalHistoryService;

        @Override
        public void handleEvent(GlobalEvent event) {
            UserId userId = new UserId(event.getString("userId"));
            IllnessCode illnessCode = new IllnessCode(event.getString("illnessId"));
            GeneralDate registerDate = event.getGeneralDate("answerDate");

            personalMedicalHistoryService.add(
                new PersonalMedicalHistory(
                    userId, registerDate, illnessCode, 
                    new IllnessStatusCode(IllnessStatus.DURING_TREATMENT)));
        }
    }