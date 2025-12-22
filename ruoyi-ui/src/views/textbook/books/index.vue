<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="ISBN" prop="isbn">
        <el-input
          v-model="queryParams.isbn"
          placeholder="请输入ISBN"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="教材名称" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入教材名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="作者" prop="author">
        <el-input
          v-model="queryParams.author"
          placeholder="请输入作者"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="出版社" prop="publisherId">
        <el-input
          v-model="queryParams.publisherId"
          placeholder="请输入出版社"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="教材类型" prop="categoryId">
        <el-input
          v-model="queryParams.categoryId"
          placeholder="请输入教材类型"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="定价" prop="price">
        <el-input
          v-model="queryParams.price"
          placeholder="请输入定价"
          clearable
          @keyup.enter="handleQuery"
        />
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
          v-hasPermi="['textbook:books:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['textbook:books:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['textbook:books:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['textbook:books:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="booksList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="教材ID" align="center" prop="textbookId" />
      <el-table-column label="图片" align="center" prop="picture" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.picture" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="ISBN" align="center" prop="isbn" />
      <el-table-column label="教材名称" align="center" prop="title" />
      <el-table-column label="作者" align="center" prop="author" />
      <el-table-column label="出版社" align="center" prop="publisherId" />
      <el-table-column label="教材类型" align="center" prop="categoryId" />
      <el-table-column label="版次" align="center" prop="edition" />
      <el-table-column label="定价" align="center" prop="price" />
      <el-table-column label="添加人" align="center" prop="createdBy" />
      <el-table-column label="创建时间" align="center" prop="createdAt" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['textbook:books:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['textbook:books:remove']">删除</el-button>
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

    <!-- 添加或修改教材信息对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="booksRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="图片" prop="picture">
          <image-upload v-model="form.picture"/>
        </el-form-item>
        <el-form-item label="ISBN" prop="isbn">
          <el-input v-model="form.isbn" placeholder="请输入ISBN" />
        </el-form-item>
        <el-form-item label="教材名称" prop="title">
          <el-input v-model="form.title" placeholder="请输入教材名称" />
        </el-form-item>
        <el-form-item label="作者" prop="author">
          <el-input v-model="form.author" placeholder="请输入作者" />
        </el-form-item>
        <el-form-item label="出版社" prop="publisherId">
          <el-input v-model="form.publisherId" placeholder="请输入出版社" />
        </el-form-item>
        <el-form-item label="教材类型" prop="categoryId">
          <el-input v-model="form.categoryId" placeholder="请输入教材类型" />
        </el-form-item>
        <el-form-item label="版次" prop="edition">
          <el-input v-model="form.edition" placeholder="请输入版次" />
        </el-form-item>
        <el-form-item label="定价" prop="price">
          <el-input v-model="form.price" placeholder="请输入定价" />
        </el-form-item>
        <el-form-item label="添加人" prop="createdBy">
          <el-input v-model="form.createdBy" placeholder="请输入添加人" />
        </el-form-item>
        <el-form-item label="创建时间" prop="createdAt">
          <el-date-picker clearable
            v-model="form.createdAt"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择创建时间">
          </el-date-picker>
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

<script setup name="Books">
import { listBooks, getBooks, delBooks, addBooks, updateBooks } from "@/api/textbook/books"

const { proxy } = getCurrentInstance()

const booksList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    isbn: null,
    title: null,
    author: null,
    publisherId: null,
    categoryId: null,
    price: null,
  },
  rules: {
    isbn: [
      { required: true, message: "ISBN不能为空", trigger: "blur" }
    ],
    title: [
      { required: true, message: "教材名称不能为空", trigger: "blur" }
    ],
    publisherId: [
      { required: true, message: "出版社不能为空", trigger: "blur" }
    ],
    categoryId: [
      { required: true, message: "教材类型不能为空", trigger: "blur" }
    ],
    edition: [
      { required: true, message: "版次不能为空", trigger: "blur" }
    ],
    price: [
      { required: true, message: "定价不能为空", trigger: "blur" }
    ],
    createdAt: [
      { required: true, message: "创建时间不能为空", trigger: "blur" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询教材信息列表 */
function getList() {
  loading.value = true
  listBooks(queryParams.value).then(response => {
    booksList.value = response.rows
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
    textbookId: null,
    picture: null,
    isbn: null,
    title: null,
    author: null,
    publisherId: null,
    categoryId: null,
    edition: null,
    price: null,
    createdBy: null,
    createdAt: null
  }
  proxy.resetForm("booksRef")
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
  ids.value = selection.map(item => item.textbookId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加教材信息"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _textbookId = row.textbookId || ids.value
  getBooks(_textbookId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改教材信息"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["booksRef"].validate(valid => {
    if (valid) {
      if (form.value.textbookId != null) {
        updateBooks(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addBooks(form.value).then(response => {
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
  const _textbookIds = row.textbookId || ids.value
  proxy.$modal.confirm('是否确认删除教材信息编号为"' + _textbookIds + '"的数据项？').then(function() {
    return delBooks(_textbookIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('textbook/books/export', {
    ...queryParams.value
  }, `books_${new Date().getTime()}.xlsx`)
}

getList()
</script>
