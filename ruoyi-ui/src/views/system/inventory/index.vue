<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="教材" prop="textbookId">
        <el-select v-model="queryParams.textbookId" placeholder="请选择教材" clearable filterable>
          <el-option
            v-for="item in textbookOptions"
            :key="item.textbookId"
            :label="item.title"
            :value="item.textbookId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="课程类型" prop="categoryId">
        <el-select v-model="queryParams.categoryId" placeholder="请选择课程类型" clearable filterable>
          <el-option
            v-for="item in categoryOptions"
            :key="item.categoryId"
            :label="item.categoryName"
            :value="item.categoryId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="所属学院" prop="collegeId">
        <el-select 
          v-model="queryParams.collegeId" 
          placeholder="请选择所属学院" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in collegeOptions"
            :key="item.deptId"
            :label="item.deptName"
            :value="item.deptId"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['system:inventory:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="multiple"
          @click="handleUpdate"
          v-hasPermi="['system:inventory:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="FolderOpened"
          :disabled="multiple"
          @click="handleInbound"
          v-hasPermi="['system:inventory:inbound']"
        >入库登记</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Folder"
          :disabled="multiple"
          @click="handleOutbound"
          v-hasPermi="['system:inventory:outbound']"
        >出库登记</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="User"
          :disabled="multiple"
          @click="handleIssue"
          v-hasPermi="['system:inventory:issue']"
        >教材领用</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:inventory:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['system:inventory:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="inventoryList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="库存记录ID" align="center" prop="inventoryId" />
      <el-table-column label="教材" align="center" prop="textbookId">
        <template #default="scope">
          <span v-for="textbook in textbookOptions" :key="textbook.textbookId">
            <span v-if="textbook.textbookId === scope.row.textbookId">{{ textbook.title }}</span>
          </span>
        </template>
      </el-table-column>
      <el-table-column label="课程类型" align="center" prop="categoryId">
        <template #default="scope">
          <span v-for="category in categoryOptions" :key="category.categoryId">
            <span v-if="category.categoryId === scope.row.categoryId">{{ category.categoryName }}</span>
          </span>
        </template>
      </el-table-column>
      <el-table-column label="所属学院" align="center" prop="collegeId">
        <template #default="scope">
          <span v-for="college in collegeOptions" :key="college.deptId">
            <span v-if="college.deptId === scope.row.collegeId">{{ college.deptName }}</span>
          </span>
        </template>
      </el-table-column>
      <el-table-column label="总数量" align="center" prop="totalQuantity" />
      <el-table-column label="可领用数量" align="center" prop="availableQuantity" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:inventory:edit']">修改</el-button>
          <el-button link type="primary" icon="FolderOpened" @click="handleInboundSingle(scope.row)" v-hasPermi="['system:inventory:inbound']">入库</el-button>
          <el-button link type="primary" icon="Folder" @click="handleOutboundSingle(scope.row)" v-hasPermi="['system:inventory:outbound']">出库</el-button>
          <el-button link type="primary" icon="User" @click="handleIssueSingle(scope.row)" v-hasPermi="['system:inventory:issue']">领用</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['system:inventory:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改教材库存对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="inventoryRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="教材" prop="textbookId">
          <el-select v-model="form.textbookId" placeholder="请选择教材" clearable filterable>
            <el-option
              v-for="item in textbookOptions"
              :key="item.textbookId"
              :label="item.title"
              :value="item.textbookId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="课程类型" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择课程类型" clearable filterable>
            <el-option
              v-for="item in categoryOptions"
              :key="item.categoryId"
              :label="item.categoryName"
              :value="item.categoryId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="所属学院" prop="collegeId">
          <el-select 
            v-model="form.collegeId" 
            placeholder="请选择所属学院" 
            clearable 
            filterable
          >
            <el-option
              v-for="item in collegeOptions"
              :key="item.deptId"
              :label="item.deptName"
              :value="item.deptId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="总数量" prop="totalQuantity">
          <el-input-number v-model="form.totalQuantity" controls-position="right" :min="0" placeholder="请输入总数量" style="width: 100%" />
        </el-form-item>
        <el-form-item label="可领用数量" prop="availableQuantity">
          <el-input-number v-model="form.availableQuantity" controls-position="right" :min="0" placeholder="请输入可领用数量" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
    
    <!-- 入库登记对话框 -->
    <el-dialog :title="inboundTitle" v-model="inboundOpen" width="500px" append-to-body>
      <el-form ref="inboundRef" :model="inboundForm" :rules="inboundRules" label-width="100px">
        <el-form-item label="教材" prop="textbookId">
          <el-select v-model="inboundForm.textbookId" placeholder="请选择教材" clearable filterable disabled>
            <el-option
              v-for="item in textbookOptions"
              :key="item.textbookId"
              :label="item.title"
              :value="item.textbookId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="入库数量" prop="quantity">
          <el-input-number v-model="inboundForm.quantity" controls-position="right" :min="1" placeholder="请输入入库数量" style="width: 100%" />
        </el-form-item>
        <el-form-item label="供应商" prop="supplier">
          <el-input v-model="inboundForm.supplier" placeholder="请输入供应商名称" />
        </el-form-item>
        <el-form-item label="入库日期" prop="inboundDate">
          <el-date-picker clearable
            v-model="inboundForm.inboundDate"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择入库日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input v-model="inboundForm.notes" type="textarea" placeholder="请输入备注信息" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitInboundForm">确 定</el-button>
          <el-button @click="cancelInbound">取 消</el-button>
        </div>
      </template>
    </el-dialog>
    
    <!-- 出库登记对话框 -->
    <el-dialog :title="outboundTitle" v-model="outboundOpen" width="500px" append-to-body>
      <el-form ref="outboundRef" :model="outboundForm" :rules="outboundRules" label-width="100px">
        <el-form-item label="教材" prop="textbookId">
          <el-select v-model="outboundForm.textbookId" placeholder="请选择教材" clearable filterable disabled>
            <el-option
              v-for="item in textbookOptions"
              :key="item.textbookId"
              :label="item.title"
              :value="item.textbookId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="出库数量" prop="quantity">
          <el-input-number v-model="outboundForm.quantity" controls-position="right" :min="1" :max="outboundMaxQuantity" placeholder="请输入出库数量" style="width: 100%" />
        </el-form-item>
        <el-form-item label="领用人" prop="recipient">
          <el-input v-model="outboundForm.recipient" placeholder="请输入领用人姓名" />
        </el-form-item>
        <el-form-item label="出库日期" prop="outboundDate">
          <el-date-picker clearable
            v-model="outboundForm.outboundDate"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择出库日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="用途" prop="purpose">
          <el-select v-model="outboundForm.purpose" placeholder="请选择用途" clearable>
            <el-option label="教师领用" value="teacher"></el-option>
            <el-option label="学生领用" value="student"></el-option>
            <el-option label="其他" value="other"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input v-model="outboundForm.notes" type="textarea" placeholder="请输入备注信息" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitOutboundForm">确 定</el-button>
          <el-button @click="cancelOutbound">取 消</el-button>
        </div>
      </template>
    </el-dialog>
    
    <!-- 教材领用对话框 -->
    <el-dialog :title="issueTitle" v-model="issueOpen" width="500px" append-to-body>
      <el-form ref="issueRef" :model="issueForm" :rules="issueRules" label-width="100px">
        <el-form-item label="教材" prop="textbookId">
          <el-select v-model="issueForm.textbookId" placeholder="请选择教材" clearable filterable disabled>
            <el-option
              v-for="item in textbookOptions"
              :key="item.textbookId"
              :label="item.title"
              :value="item.textbookId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="领用数量" prop="quantity">
          <el-input-number v-model="issueForm.quantity" controls-position="right" :min="1" :max="issueMaxQuantity" placeholder="请输入领用数量" style="width: 100%" />
        </el-form-item>
        <el-form-item label="领用人" prop="recipient">
          <el-input v-model="issueForm.recipient" placeholder="请输入领用人姓名" />
        </el-form-item>
        <el-form-item label="领用日期" prop="issueDate">
          <el-date-picker clearable
            v-model="issueForm.issueDate"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择领用日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="用途" prop="purpose">
          <el-select v-model="issueForm.purpose" placeholder="请选择用途" clearable>
            <el-option label="教师领用" value="teacher"></el-option>
            <el-option label="学生领用" value="student"></el-option>
            <el-option label="其他" value="other"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="notes">
          <el-input v-model="issueForm.notes" type="textarea" placeholder="请输入备注信息" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitIssueForm">确 定</el-button>
          <el-button @click="cancelIssue">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="InventoryList">
import { listInventory, getInventory, delInventory, addInventory, updateInventory } from "@/api/system/inventory"
import { listBooks } from "@/api/textbook/books"
import { addLogs } from "@/api/system/logs"
import { listCategories } from "@/api/system/categories"
import { listDept } from "@/api/system/dept"
import { deptTreeSelect } from "@/api/system/user"
import useUserStore from '@/store/modules/user'

const { proxy } = getCurrentInstance()
const userStore = useUserStore()

const inventoryList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const textbookOptions = ref([])
const categoryOptions = ref([])
const collegeOptions = ref([])

// 入库相关变量
const inboundOpen = ref(false)
const inboundTitle = ref("")
const inboundForm = ref({})
const inboundRules = {
  textbookId: [
    { required: true, message: "教材不能为空", trigger: "change" }
  ],
  quantity: [
    { required: true, message: "入库数量不能为空", trigger: "blur" },
    { type: "number", min: 1, message: "入库数量必须大于0", trigger: "blur" }
  ],
  supplier: [
    { required: true, message: "供应商不能为空", trigger: "blur" }
  ],
  inboundDate: [
    { required: true, message: "入库日期不能为空", trigger: "blur" }
  ]
}

// 出库相关变量
const outboundOpen = ref(false)
const outboundTitle = ref("")
const outboundForm = ref({})
const outboundMaxQuantity = ref(0)
const outboundRules = {
  textbookId: [
    { required: true, message: "教材不能为空", trigger: "change" }
  ],
  quantity: [
    { required: true, message: "出库数量不能为空", trigger: "blur" },
    { type: "number", min: 1, message: "出库数量必须大于0", trigger: "blur" }
  ],
  recipient: [
    { required: true, message: "领用人不能为空", trigger: "blur" }
  ],
  outboundDate: [
    { required: true, message: "出库日期不能为空", trigger: "blur" }
  ],
  purpose: [
    { required: true, message: "用途不能为空", trigger: "change" }
  ]
}

// 教材领用相关变量
const issueOpen = ref(false)
const issueTitle = ref("")
const issueForm = ref({})
const issueMaxQuantity = ref(0)
const issueRules = {
  textbookId: [
    { required: true, message: "教材不能为空", trigger: "change" }
  ],
  quantity: [
    { required: true, message: "领用数量不能为空", trigger: "blur" },
    { type: "number", min: 1, message: "领用数量必须大于0", trigger: "blur" }
  ],
  recipient: [
    { required: true, message: "领用人不能为空", trigger: "blur" }
  ],
  issueDate: [
    { required: true, message: "领用日期不能为空", trigger: "blur" }
  ],
  purpose: [
    { required: true, message: "用途不能为空", trigger: "change" }
  ]
}

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    textbookId: null,
    categoryId: null,
    collegeId: null
  },
  rules: {
    textbookId: [
      { required: true, message: "教材不能为空", trigger: "change" }
    ],
    categoryId: [
      { required: true, message: "课程类型不能为空", trigger: "change" }
    ],
    collegeId: [
      { required: true, message: "所属学院不能为空", trigger: "change" }
    ],
    totalQuantity: [
      { required: true, message: "总数量不能为空", trigger: "blur" },
      { type: "number", min: 0, message: "总数量必须大于等于0", trigger: "blur" },
      { validator: validateTotalQuantity, trigger: "blur" }
    ],
    availableQuantity: [
      { required: true, message: "可领用数量不能为空", trigger: "blur" },
      { type: "number", min: 0, message: "可领用数量必须大于等于0", trigger: "blur" },
      { validator: validateAvailableQuantity, trigger: "blur" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

// 验证总数量不能小于可领用数量
function validateTotalQuantity(rule, value, callback) {
  if (value !== null && value !== undefined && form.value.availableQuantity !== null && form.value.availableQuantity !== undefined) {
    if (parseInt(value) < parseInt(form.value.availableQuantity)) {
      callback(new Error("总数量不能小于可领用数量"));
    } else {
      callback();
    }
  } else {
    callback();
  }
}

// 验证可领用数量不能大于总数量
function validateAvailableQuantity(rule, value, callback) {
  if (value !== null && value !== undefined && form.value.totalQuantity !== null && form.value.totalQuantity !== undefined) {
    if (parseInt(value) > parseInt(form.value.totalQuantity)) {
      callback(new Error("可领用数量不能大于总数量"));
    } else {
      callback();
    }
  } else {
    callback();
  }
}

/** 查询教材列表 */
function getTextbookList() {
  listBooks({ pageSize: 1000 }).then(response => {
    textbookOptions.value = response.rows
  })
}

/** 查询教材类型列表 */
function getCategoryList() {
  listCategories({ pageSize: 1000 }).then(response => {
    categoryOptions.value = response.rows
  })
}

/** 查询学院列表 */
function getCollegeList() {
  deptTreeSelect().then(response => {
    // 过滤出二级目录作为学院选项
    collegeOptions.value = [];
    
    if (response.data && Array.isArray(response.data)) {
      // 遍历所有顶级部门
      response.data.forEach(dept => {
        // 检查是否有子部门
        if (dept.children && Array.isArray(dept.children) && dept.children.length > 0) {
          // 将子部门作为学院添加到选项中
          dept.children.forEach(college => {
            // 兼容不同的字段名
            const collegeOption = {
              deptId: college.id || college.deptId || college.value,
              deptName: college.label || college.deptName || college.name || college.title
            };
            
            // 确保必要字段存在
            if (collegeOption.deptId && collegeOption.deptName) {
              collegeOptions.value.push(collegeOption);
            }
          });
        }
      });
    }
    
    console.log('College options loaded:', collegeOptions.value);
  }).catch(error => {
    console.error('Failed to load department data:', error);
  });
}

/** 查询教材库存列表 */
function getList() {
  loading.value = true
  listInventory(queryParams.value).then(response => {
    inventoryList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 取消入库登记
function cancelInbound() {
  inboundOpen.value = false
  resetInbound()
}

// 取消出库登记
function cancelOutbound() {
  outboundOpen.value = false
  resetOutbound()
}

// 取消教材领用登记
function cancelIssue() {
  issueOpen.value = false
  resetIssue()
}

// 表单重置
function reset() {
  form.value = {
    inventoryId: null,
    textbookId: null,
    categoryId: null,
    collegeId: null,
    totalQuantity: null,
    availableQuantity: null
  }
  proxy.resetForm("inventoryRef")
}

// 入库表单重置
function resetInbound() {
  inboundForm.value = {
    textbookId: null,
    quantity: null,
    supplier: null,
    inboundDate: null,
    notes: null
  }
  proxy.resetForm("inboundRef")
}

// 出库表单重置
function resetOutbound() {
  outboundForm.value = {
    textbookId: null,
    quantity: null,
    recipient: null,
    outboundDate: null,
    purpose: null,
    notes: null
  }
  proxy.resetForm("outboundRef")
}

// 教材领用表单重置
function resetIssue() {
  issueForm.value = {
    textbookId: null,
    quantity: null,
    recipient: null,
    issueDate: null,
    purpose: null,
    notes: null
  }
  proxy.resetForm("issueRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.inventoryId)
  single.value = selection.length === 1  // 当选择1条记录时为true，其他情况为false
  multiple.value = selection.length > 1  // 当选择多条记录时为true，否则为false
}

// 添加日志记录函数
function addLogRecord(textbookId, operation, quantity, notes = '', relatedRequestId = null) {
  const logData = {
    textbookId: textbookId,
    operation: operation, // 0: 入库, 1: 出库
    quantity: quantity,
    operatorId: userStore.id,
    relatedRequestId: relatedRequestId, // 关联的申请ID
    notes: notes,
    createdAt: new Date().toISOString().slice(0, 10)
  };
  
  addLogs(logData).then(() => {
    console.log('日志记录添加成功');
  }).catch(error => {
    console.error('日志记录添加失败:', error);
  });
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加教材库存"
}

/** 入库登记按钮操作 */
function handleInbound() {
  if (single.value && !multiple.value && ids.value.length === 1) {
    // 获取选中项
    const selectedRow = inventoryList.value.find(item => item.inventoryId === ids.value[0]);
    if (selectedRow) {
      // 单个入库
      handleInboundSingle(selectedRow);
    } else {
      proxy.$modal.msgError("请选择一条有效的记录进行入库登记");
    }
  } else {
    // 提示选择单个
    proxy.$modal.msgError("请选择一条记录进行入库登记");
  }
}

/** 单个入库登记 */
function handleInboundSingle(row) {
  resetInbound()
  inboundForm.value = {
    textbookId: row.textbookId,
    quantity: null,
    supplier: null,
    inboundDate: new Date().toISOString().slice(0, 10),
    notes: null
  }
  inboundOpen.value = true
  inboundTitle.value = "教材入库登记"
}

/** 出库登记按钮操作 */
function handleOutbound() {
  if (single.value && !multiple.value && ids.value.length === 1) {
    // 获取选中项
    const selectedRow = inventoryList.value.find(item => item.inventoryId === ids.value[0]);
    if (selectedRow) {
      // 单个出库
      handleOutboundSingle(selectedRow);
    } else {
      proxy.$modal.msgError("请选择一条有效的记录进行出库登记");
    }
  } else {
    // 提示选择单个
    proxy.$modal.msgError("请选择一条记录进行出库登记");
  }
}

/** 单个出库登记 */
function handleOutboundSingle(row) {
  // 检查是否有足够的库存
  if (row.availableQuantity <= 0) {
    proxy.$modal.msgError("可领用数量不足，无法出库");
    return;
  }
  
  resetOutbound()
  outboundForm.value = {
    textbookId: row.textbookId,
    quantity: null,
    recipient: null,
    outboundDate: new Date().toISOString().slice(0, 10),
    purpose: null,
    notes: null
  }
  outboundMaxQuantity.value = row.availableQuantity
  outboundOpen.value = true
  outboundTitle.value = "教材出库登记"
}

/** 教材领用按钮操作 */
function handleIssue() {
  if (single.value && !multiple.value && ids.value.length === 1) {
    // 获取选中项
    const selectedRow = inventoryList.value.find(item => item.inventoryId === ids.value[0]);
    if (selectedRow) {
      // 单个领用
      handleIssueSingle(selectedRow);
    } else {
      proxy.$modal.msgError("请选择一条有效的记录进行教材领用");
    }
  } else {
    // 提示选择单个
    proxy.$modal.msgError("请选择一条记录进行教材领用");
  }
}

/** 单个教材领用 */
function handleIssueSingle(row) {
  // 检查是否有足够的库存
  if (row.availableQuantity <= 0) {
    proxy.$modal.msgError("可领用数量不足，无法领用");
    return;
  }
  
  resetIssue()
  issueForm.value = {
    textbookId: row.textbookId,
    quantity: null,
    recipient: null,
    issueDate: new Date().toISOString().slice(0, 10),
    purpose: null,
    notes: null
  }
  issueMaxQuantity.value = row.availableQuantity
  issueOpen.value = true
  issueTitle.value = "教材领用登记"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  // 如果是通过表格行点击的修改按钮，直接使用传入的行数据
  // 如果是通过工具栏的修改按钮，使用选中的行
  let _inventoryId;
  if (row && row.inventoryId) {
    _inventoryId = row.inventoryId;
  } else if (single.value && ids.value.length === 1) {
    _inventoryId = ids.value[0];
  } else {
    proxy.$modal.msgError("请选择一条记录进行修改");
    return;
  }
  
  getInventory(_inventoryId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改教材库存"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["inventoryRef"].validate(valid => {
    if (valid) {
      if (form.value.inventoryId != null) {
        // 获取修改前的库存数据，用于计算数量变化
        getInventory(form.value.inventoryId).then(originalResponse => {
          const originalData = originalResponse.data;
          const totalQuantityDiff = form.value.totalQuantity - (originalData.totalQuantity || 0);
          const availableQuantityDiff = form.value.availableQuantity - (originalData.availableQuantity || 0);
          
          updateInventory(form.value).then(response => {
            proxy.$modal.msgSuccess("修改成功")
            
            // 记录总数量变化日志
            if (totalQuantityDiff !== 0) {
              const operationType = totalQuantityDiff > 0 ? '0' : '1'; // 0: 入库, 1: 出库
              const quantity = Math.abs(totalQuantityDiff);
              const notes = `库存数量变更: ${originalData.totalQuantity || 0} -> ${form.value.totalQuantity}`;
              addLogRecord(form.value.textbookId, operationType, quantity, notes);
            }
            
            // 记录可用数量变化日志
            if (availableQuantityDiff !== 0) {
              const operationType = availableQuantityDiff > 0 ? '0' : '1'; // 0: 入库, 1: 出库
              const quantity = Math.abs(availableQuantityDiff);
              const notes = `可用库存数量变更: ${originalData.availableQuantity || 0} -> ${form.value.availableQuantity}`;
              addLogRecord(form.value.textbookId, operationType, quantity, notes);
            }
            
            open.value = false
            getList()
          })
        });
      } else {
        addInventory(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          
          // 记录新增库存日志
          if (form.value.totalQuantity > 0) {
            const notes = `新增库存记录，初始数量: ${form.value.totalQuantity}`;
            addLogRecord(form.value.textbookId, '0', form.value.totalQuantity, notes); // 0: 入库
          }
          
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 提交入库表单 */
function submitInboundForm() {
  proxy.$refs["inboundRef"].validate(valid => {
    if (valid) {
      // 更新库存
      getInventoryByTextbookId(inboundForm.value.textbookId).then(response => {
        const inventoryData = response.data;
        if (inventoryData) {
          // 更新现有库存
          const updatedInventory = {
            ...inventoryData,
            totalQuantity: (inventoryData.totalQuantity || 0) + inboundForm.value.quantity,
            availableQuantity: (inventoryData.availableQuantity || 0) + inboundForm.value.quantity
          };
          
          // 验证总数量不能小于可用数量
          if (updatedInventory.totalQuantity < updatedInventory.availableQuantity) {
            proxy.$modal.msgError("入库后总数量不能小于可用数量");
            return;
          }
          
          updateInventory(updatedInventory).then(response => {
            // 添加入库日志记录
            const notes = `入库登记 - 供应商: ${inboundForm.value.supplier}, 数量: ${inboundForm.value.quantity}`;
            addLogRecord(inboundForm.value.textbookId, '0', inboundForm.value.quantity, notes);
            
            proxy.$modal.msgSuccess("入库登记成功");
            inboundOpen.value = false;
            getList();
          }).catch(error => {
            console.error('库存更新失败:', error);
            proxy.$modal.msgError("入库登记失败");
          });
        } else {
          proxy.$modal.msgError("找不到对应的库存记录，请先添加库存");
        }
      }).catch(() => {
        // 如果找不到库存记录，创建新的库存记录
        const newInventory = {
          textbookId: inboundForm.value.textbookId,
          categoryId: getTextbookById(inboundForm.value.textbookId)?.categoryId || null,
          collegeId: getCollegeByTextbookId(inboundForm.value.textbookId),
          totalQuantity: inboundForm.value.quantity,
          availableQuantity: inboundForm.value.quantity
        };
        
        addInventory(newInventory).then(response => {
          // 添加入库日志记录
          const notes = `首次入库登记 - 供应商: ${inboundForm.value.supplier}, 数量: ${inboundForm.value.quantity}`;
          addLogRecord(inboundForm.value.textbookId, '0', inboundForm.value.quantity, notes);
          
          proxy.$modal.msgSuccess("入库登记成功");
          inboundOpen.value = false;
          getList();
        }).catch(error => {
          console.error('库存创建失败:', error);
          proxy.$modal.msgError("入库登记失败");
        });
      });
    }
  });
}

/** 提交出库表单 */
function submitOutboundForm() {
  proxy.$refs["outboundRef"].validate(valid => {
    if (valid) {
      // 检查出库数量是否超过可用库存
      if (outboundForm.value.quantity > outboundMaxQuantity.value) {
        proxy.$modal.msgError("出库数量不能超过可领用数量");
        return;
      }
      
      // 更新库存
      getInventoryByTextbookId(outboundForm.value.textbookId).then(response => {
        const inventoryData = response.data;
        if (inventoryData) {
          // 更新现有库存
          const updatedInventory = {
            ...inventoryData,
            totalQuantity: (inventoryData.totalQuantity || 0) - outboundForm.value.quantity,
            availableQuantity: (inventoryData.availableQuantity || 0) - outboundForm.value.quantity
          };
          
          // 验证数量不能为负数
          if (updatedInventory.totalQuantity < 0 || updatedInventory.availableQuantity < 0) {
            proxy.$modal.msgError("库存数量不能为负数");
            return;
          }
          
          // 验证总数量不能小于可用数量
          if (updatedInventory.totalQuantity < updatedInventory.availableQuantity) {
            proxy.$modal.msgError("出库后总数量不能小于可用数量");
            return;
          }
          
          updateInventory(updatedInventory).then(response => {
            // 添加出库日志记录
            const notes = `出库登记 - 领用人: ${outboundForm.value.recipient}, 用途: ${outboundForm.value.purpose}, 数量: ${outboundForm.value.quantity}`;
            addLogRecord(outboundForm.value.textbookId, '1', outboundForm.value.quantity, notes);
            
            proxy.$modal.msgSuccess("出库登记成功");
            outboundOpen.value = false;
            getList();
          }).catch(error => {
            console.error('库存更新失败:', error);
            proxy.$modal.msgError("出库登记失败");
          });
        } else {
          proxy.$modal.msgError("找不到对应的库存记录");
        }
      }).catch(() => {
        proxy.$modal.msgError("找不到对应的库存记录");
      });
    }
  });
}

/** 提交教材领用表单 */
function submitIssueForm() {
  proxy.$refs["issueRef"].validate(valid => {
    if (valid) {
      // 检查领用数量是否超过可用库存
      if (issueForm.value.quantity > issueMaxQuantity.value) {
        proxy.$modal.msgError("领用数量不能超过可领用数量");
        return;
      }
      
      // 更新库存
      getInventoryByTextbookId(issueForm.value.textbookId).then(response => {
        const inventoryData = response.data;
        if (inventoryData) {
          // 更新现有库存 - 领用会减少可用数量，但不影响总数量
          const updatedInventory = {
            ...inventoryData,
            totalQuantity: (inventoryData.totalQuantity || 0), // 领用不改变总数量
            availableQuantity: (inventoryData.availableQuantity || 0) - issueForm.value.quantity
          };
          
          // 验证数量不能为负数
          if (updatedInventory.availableQuantity < 0) {
            proxy.$modal.msgError("库存数量不能为负数");
            return;
          }
          
          // 验证总数量不能小于可用数量
          if (updatedInventory.totalQuantity < updatedInventory.availableQuantity) {
            proxy.$modal.msgError("总数量不能小于可用数量");
            return;
          }
          
          updateInventory(updatedInventory).then(response => {
            // 添加领用日志记录
            const notes = `教材领用 - 领用人: ${issueForm.value.recipient}, 用途: ${issueForm.value.purpose}, 数量: ${issueForm.value.quantity}`;
            addLogRecord(issueForm.value.textbookId, '1', issueForm.value.quantity, notes, null);
            
            proxy.$modal.msgSuccess("教材领用成功");
            issueOpen.value = false;
            getList();
          }).catch(error => {
            console.error('库存更新失败:', error);
            proxy.$modal.msgError("教材领用失败");
          });
        } else {
          proxy.$modal.msgError("找不到对应的库存记录");
        }
      }).catch(() => {
        proxy.$modal.msgError("找不到对应的库存记录");
      });
    }
  });
}

/** 根据教材ID获取库存信息 */
function getInventoryByTextbookId(textbookId) {
  return new Promise((resolve, reject) => {
    // 先尝试从列表中查找
    const existing = inventoryList.value.find(item => item.textbookId === textbookId);
    if (existing) {
      getInventory(existing.inventoryId).then(response => {
        resolve(response);
      }).catch(reject);
    } else {
      // 如果列表中没有，通过API查询
      listInventory({ textbookId: textbookId, pageSize: 1 }).then(response => {
        if (response.rows && response.rows.length > 0) {
          getInventory(response.rows[0].inventoryId).then(res => {
            resolve(res);
          }).catch(reject);
        } else {
          reject(new Error('Inventory not found'));
        }
      }).catch(reject);
    }
  });
}

/** 根据教材ID获取教材信息 */
function getTextbookById(textbookId) {
  if (!textbookId || !textbookOptions.value) return null;
  return textbookOptions.value.find(item => item.textbookId === textbookId);
}

/** 根据教材ID获取所属学院（简化处理） */
function getCollegeByTextbookId(textbookId) {
  // 这里可以根据教材的使用情况或教学计划来确定所属学院
  // 暂时返回默认值或空值
  return null;
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _inventoryIds = row.inventoryId || ids.value
  proxy.$modal.confirm('是否确认删除教材库存编号为"' + _inventoryIds + '"的数据项？').then(function() {
    return delInventory(_inventoryIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('system/inventory/export', {
    ...queryParams.value
  }, `inventory_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList()
  getTextbookList()
  getCategoryList()
  getCollegeList()
})
</script>