import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("uat") {
            dimension = "flavor-type"
            applicationId = "com.romanbot4.jdonutsuat"
            resValue(type = "string", name = "app_name", value = "JDonuts UAT")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.romanbot4.jdonuts"
            resValue(type = "string", name = "app_name", value = "JDonuts")
        }
    }

    buildFeatures.resValues = true
}