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
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:inventory:edit']"
        >修改</el-button>
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
      <el-table-column label="总数量" align="center" prop="totalQuantity" />
      <el-table-column label="可领用数量" align="center" prop="availableQuantity" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['system:inventory:edit']">修改</el-button>
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
      <el-form ref="inventoryRef" :model="form" :rules="rules" label-width="80px">
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
  </div>
</template>

<script setup name="Inventory">
import { listInventory, getInventory, delInventory, addInventory, updateInventory } from "@/api/system/inventory"
import { listBooks } from "@/api/textbook/books"

const { proxy } = getCurrentInstance()

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

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    textbookId: null,
  },
  rules: {
    textbookId: [
      { required: true, message: "教材不能为空", trigger: "change" }
    ],
    totalQuantity: [
      { required: true, message: "总数量不能为空", trigger: "blur" },
      { type: "number", min: 0, message: "总数量必须大于等于0", trigger: "blur" }
    ],
    availableQuantity: [
      { required: true, message: "可领用数量不能为空", trigger: "blur" },
      { type: "number", min: 0, message: "可领用数量必须大于等于0", trigger: "blur" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询教材列表 */
function getTextbookList() {
  listBooks({ pageSize: 1000 }).then(response => {
    textbookOptions.value = response.rows
  })
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

// 表单重置
function reset() {
  form.value = {
    inventoryId: null,
    textbookId: null,
    totalQuantity: null,
    availableQuantity: null
  }
  proxy.resetForm("inventoryRef")
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
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加教材库存"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _inventoryId = row.inventoryId || ids.value
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
        updateInventory(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addInventory(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
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
})
</script>