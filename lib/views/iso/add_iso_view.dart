import 'package:b2b_partnership_admin/controller/iso/iso_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddCertificationScreen extends StatefulWidget {
  const AddCertificationScreen({super.key});

  @override
  State<AddCertificationScreen> createState() => _AddCertificationScreenState();
}

class _AddCertificationScreenState extends State<AddCertificationScreen> {
  final controller = Get.put(IsoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Certification'.tr),
      ),
      body: GetBuilder<IsoController>(
        builder: (controller) => Form(
          key: controller.formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: [10, 5],
                  strokeWidth: 1,
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                ),
                child: Center(
                  child: InkWell(
                    onTap: controller.pickPdfFile,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          controller.pdfFileName != null
                              ? Icons.check_circle
                              : Icons.upload,
                          size: 48,
                          color: controller.pdfFileName != null
                              ? Colors.green
                              : greyColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          controller.pdfFileName ?? 'Upload PDF Certificate',
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.pdfFileName != null
                                ? Colors.green
                                : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (controller.pdfFileName != null)
                          TextButton.icon(
                            onPressed: () =>
                                setState(() => controller.pdfFileName = null),
                            icon: const Icon(Icons.close, size: 16),
                            label: const Text('Remove'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: controller.priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter certification price',
                  prefixIcon: const Icon(Icons.money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  return controller.validUserData(value);
                },
              ),
              Gap(16),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter certification name',
                  prefixIcon: const Icon(Icons.title_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  return controller.validUserData(value);
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter certification title',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  return controller.validUserData(value);
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter certification description',
                  prefixIcon: const Icon(Icons.description),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  return controller.validUserData(value);
                },
              ),

              const SizedBox(height: 24),

              // buildSectionHeader('What\'s Included', () {
              //   controller.addIncludedItem(context);
              // }),
              // if (controller.includedItems.isEmpty)
              //   const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 16),
              //     child: Text(
              //       'No items added yet',
              //       style: TextStyle(
              //           color: Colors.grey, fontStyle: FontStyle.italic),
              //     ),
              //   )
              // else
              //   ...controller.includedItems.asMap().entries.map((entry) {
              //     return buildIncludedItemCard(entry.key, entry.value, () {
              //       controller.removeIncluded(entry.key);
              //     });
              //   }),
              // const SizedBox(height: 24),

              // // Benefits Section
              // buildSectionHeader(
              //     'Benefits', () => controller.addBenefit(context)),
              // if (controller.benefits.isEmpty)
              //   const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 16),
              //     child: Text(
              //       'No benefits added yet',
              //       style: TextStyle(
              //           color: Colors.grey, fontStyle: FontStyle.italic),
              //     ),
              //   )
              // else
              //   ...controller.benefits.asMap().entries.map((entry) {
              //     return buildBenefitCard(entry.value, () {
              //       controller.removeBenefits(
              //         entry.key,
              //       );
              //     });
              //   }),
              // const SizedBox(height: 32),

              // Save Button
              CustomLoadingButton(
                  onPressed: () {
                    controller.addIso();
                  },
                  text: "Save Certification"),

              Gap(40)
            ],
          ),
        ),
      ),
    );
  }
}
