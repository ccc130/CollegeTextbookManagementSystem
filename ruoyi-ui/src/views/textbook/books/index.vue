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
        <el-select v-model="queryParams.publisherId" placeholder="请选择出版社" clearable filterable>
          <el-option
            v-for="item in publisherOptions"
            :key="item.publisherId"
            :label="item.publisherName"
            :value="item.publisherId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="教材类型" prop="categoryId">
        <el-select v-model="queryParams.categoryId" placeholder="请选择教材类型" clearable filterable>
          <el-option
            v-for="item in categoryOptions"
            :key="item.categoryId"
            :label="item.categoryName"
            :value="item.categoryId"
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
      <el-table-column label="出版社" align="center" prop="publisherId">
        <template #default="scope">
          {{ getPublisherNameById(scope.row.publisherId) }}
        </template>
      </el-table-column>
      <el-table-column label="教材类型" align="center" prop="categoryId">
        <template #default="scope">
          {{ getCategoryNameById(scope.row.categoryId) }}
        </template>
      </el-table-column>
      <el-table-column label="版次" align="center" prop="edition" />
      <el-table-column label="定价" align="center" prop="price" />
      <el-table-column label="添加人" align="center" prop="createdBy">
        <template #default="scope">
          {{ getUserNameById(scope.row.createdBy) }}
        </template>
      </el-table-column>
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
          <el-select v-model="form.publisherId" placeholder="请选择出版社" clearable filterable>
            <el-option
              v-for="item in publisherOptions"
              :key="item.publisherId"
              :label="item.publisherName"
              :value="item.publisherId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="教材类型" prop="categoryId">
          <el-select v-model="form.categoryId" placeholder="请选择教材类型" clearable filterable>
            <el-option
              v-for="item in categoryOptions"
              :key="item.categoryId"
              :label="item.categoryName"
              :value="item.categoryId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="版次" prop="edition">
          <el-input v-model="form.edition" placeholder="请输入版次" />
        </el-form-item>
        <el-form-item label="定价" prop="price">
          <el-input v-model="form.price" placeholder="请输入定价" />
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
import { listPublishers } from "@/api/system/publishers"
import { listCategories } from "@/api/system/categories"
import { listUser } from "@/api/system/user"
import useUserStore from '@/store/modules/user'

const { proxy } = getCurrentInstance()
const userStore = useUserStore()

const booksList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const publisherOptions = ref([])
const categoryOptions = ref([])
const userOptions = ref([])

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
      { required: true, message: "ISBN不能为空", trigger: "blur" },
      { pattern: /^ISBN\d{10}$/, message: "ISBN格式不正确，应以ISBN开头后跟10个数字", trigger: "blur" },
      { validator: validateUniqueISBN, trigger: "blur" }
    ],
    title: [
      { required: true, message: "教材名称不能为空", trigger: "blur" }
    ],
    publisherId: [
      { required: true, message: "出版社不能为空", trigger: "change" }
    ],
    categoryId: [
      { required: true, message: "教材类型不能为空", trigger: "blur" }
    ],
    edition: [
      { required: true, message: "版次不能为空", trigger: "blur" }
    ],
    price: [
      { required: true, message: "定价不能为空", trigger: "blur" },
      { pattern: /^([0-9]+)(\.\d{1,2})?$/, message: "定价必须为数字，最多两位小数", trigger: "blur" }
    ],
    createdAt: [
      { required: true, message: "创建时间不能为空", trigger: "blur" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询出版社信息列表 */
function getPublisherList() {
  listPublishers({ pageSize: 1000 }).then(response => {
    publisherOptions.value = response.rows
  })
}

/** 查询教材类型列表 */
function getCategoryList() {
  listCategories({ pageSize: 1000 }).then(response => {
    categoryOptions.value = response.rows
  })
}

/** 查询用户列表 */
function getUserList() {
  listUser({ pageSize: 1000 }).then(response => {
    userOptions.value = response.rows
  })
}

/** 查询教材信息列表 */
function getList() {
  loading.value = true
  listBooks(queryParams.value).then(response => {
    booksList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

// 根据ID获取出版社名称
function getPublisherNameById(publisherId) {
  if (!publisherId) return '';
  
  const publisher = publisherOptions.value.find(item => item.publisherId == publisherId);
  return publisher ? publisher.publisherName : publisherId;
}

// 根据ID获取教材类型名称
function getCategoryNameById(categoryId) {
  if (!categoryId) return '';
  
  const category = categoryOptions.value.find(item => item.categoryId == categoryId);
  return category ? category.categoryName : categoryId;
}

// 根据ID获取用户名称
function getUserNameById(userId) {
  if (!userId) return '';
  
  const user = userOptions.value.find(item => item.userId == userId);
  return user ? user.userName : userId;
}

/** 验证ISBN唯一性 */
function validateUniqueISBN(rule, value, callback) {
  if (!value) {
    callback()
    return
  }
  
  // 检查是否为编辑模式
  if (form.value.textbookId) {
    // 编辑模式：检查除当前教材外是否还有其他教材使用相同的ISBN
    getBooks(form.value.textbookId).then(response => {
      const currentBook = response.data
      if (currentBook.isbn === value) {
        // 如果ISBN没有改变，则通过验证
        callback()
      } else {
        // 如果ISBN改变了，检查新ISBN是否已被其他教材使用
        listBooks({ isbn: value }).then(res => {
          const existingBooks = res.rows.filter(book => book.textbookId !== form.value.textbookId)
          if (existingBooks.length > 0) {
            callback(new Error('该ISBN号已存在'))
          } else {
            callback()
          }
        })
      }
    })
  } else {
    // 添加模式：直接检查ISBN是否已存在
    listBooks({ isbn: value }).then(res => {
      if (res.rows.length > 0) {
        callback(new Error('该ISBN号已存在'))
      } else {
        callback()
      }
    })
  }
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 表单重置
function reset() {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  const currentDate = `${year}-${month}-${day}`;
  
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
    createdBy: userStore.id,
    createdAt: currentDate
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
      // 验证ISBN唯一性
      checkISBNExists(form.value.isbn, form.value.textbookId).then(isbnExists => {
        if (isbnExists) {
          proxy.$modal.msgError("该ISBN号已存在");
          return;
        }
        
        // 确保创建人字段始终为当前用户ID
        form.value.createdBy = userStore.id
        // 确保创建时间为当前日期
        if (!form.value.createdAt) {
          const now = new Date();
          const year = now.getFullYear();
          const month = String(now.getMonth() + 1).padStart(2, '0');
          const day = String(now.getDate()).padStart(2, '0');
          form.value.createdAt = `${year}-${month}-${day}`;
        }
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
      }).catch(error => {
        console.error("验证ISBN唯一性时出错:", error);
        proxy.$modal.msgError("验证ISBN唯一性时出错");
      });
    }
  })
}

/** 检查ISBN是否已存在 */
function checkISBNExists(isbn, currentTextbookId = null) {
  return new Promise((resolve, reject) => {
    listBooks({ isbn: isbn }).then(res => {
      let exists = false;
      if (currentTextbookId) {
        // 编辑模式：检查除当前教材外是否还有其他教材使用相同的ISBN
        exists = res.rows.some(book => book.textbookId !== currentTextbookId);
      } else {
        // 添加模式：检查是否有任何教材使用相同的ISBN
        exists = res.rows.length > 0;
      }
      resolve(exists);
    }).catch(error => {
      reject(error);
    });
  });
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

onMounted(() => {
  getList()
  getPublisherList()
  getCategoryList()
  getUserList()
})
</script>